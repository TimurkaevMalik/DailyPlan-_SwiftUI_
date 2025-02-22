//
//  TaskCell.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 20.08.2024.
//

import SwiftUI

struct TaskCell: View {
    
    @State private var task: TaskInfo
    @State private var offSet: CGSize
    @FocusState private var isFocused: Bool
    
    private let checkMarkButtonSize: CGSize
    private let spacing: CGFloat
    private let delete: () -> Void
    
    init(task: TaskInfo,
         delete: @escaping () -> Void) {
        self.task = task
        self.delete = delete
        offSet = .zero
        spacing = .defaultSpacing
        checkMarkButtonSize = .checkMarkButton
    }
    
    var body: some View {
        
        HStack(alignment: .bottom, spacing: spacing) {
            
            CheckMarkButton(color: task.color,
                            isDone: $task.isDone)
            .setSize(checkMarkButtonSize)
            
            VStack(alignment: .trailing, spacing: 0) {
                if let scheduleString = stringFromSchedule() {
                    buttonOf(schedule: scheduleString)
                        .offset(getOffSetAmount())
                }
                
                DescriptionView(
                    text: $task.description,
                    color: .clear,
                    focusedHeight: .large,
                    placeHolder: "Description")
                .strokeRoundedView(
                    stroke: .style(color: task.color),
                    topLeading: .mediumCornerRadius,
                    topTrailing: shouldRoundCorner(),
                    bottomLeading: .mediumCornerRadius,
                    bottomTrailing: .mediumCornerRadius)
                .focused($isFocused)
                .offset(getOffSetAmount())
                .gesture(dragGesture)
                .background(alignment: Alignment(horizontal: .trailing, vertical: .center)) {
                    
                    if !isFocused,
                       offSet != .zero {
                        
                        Button {
                            delete()
                        } label: {
                            trashImage()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    TaskCell(task: TaskInfo(
        description: "description",
        color: .ypCyan,
        schedule: .init(start: .distantPast, end: .distantFuture),
        isDone: false),
             delete: {})
    .padding(.horizontal)
}

private extension TaskCell {
    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 20, coordinateSpace: .local)
            .onChanged { value in
                if !isFocused {
                    withAnimation {
                        offSet.width = value.translation.width
                    }
                }
            }
            .onEnded { value in
                if !isFocused {
                    
                    if value.translation.width > -30 {
                        hideDeletingButton()
                    } else {
                        showDeletingButton(completion: {
                            hideDeletingButton(delay: 2)
                        })
                    }
                }
            }
    }
    
    func buttonOf(schedule: String) -> some View {
        Button {
            ///TODO: show editing menu
        } label: {
            Text(schedule)
                .padding(.horizontal, 12)
                .tint(.ypBlack)
                .strokeRoundedView(
                    stroke: .style(color: task.color),
                    topLeading: .regularCornerRadius,
                    topTrailing: .regularCornerRadius,
                    bottomLeading: 0,
                    bottomTrailing: 0)
        }
    }
    
    func trashImage() -> some View {
        Image(systemName: "trash")
            .foregroundStyle(.messRed)
            .setSize(.checkMarkButton)
            .padding(.trailing, 6)
            .padding(.leading, 20)
            .background {
                RoundedRectangle(cornerRadius: .mediumCornerRadius)
                    .stroke(.messRed, lineWidth: 2)
                    .clipShape(.rect(cornerRadius: .mediumCornerRadius))
            }
    }
}

private extension TaskCell {
    func getOffSetAmount() -> CGSize {
        let minWidth = 0.0
        let maxWidth = -(checkMarkButtonSize.width + spacing)
        let currentWidth = offSet.width
        
        return CGSize(width: min(minWidth, max(maxWidth, currentWidth)), height: 0)
    }
    
    func showDeletingButton(completion: @escaping () -> Void) {
        withAnimation {
            offSet.width = -(checkMarkButtonSize.width + spacing)
        } completion: {
            completion()
        }
    }
    
    func hideDeletingButton(delay: CGFloat = 0) {
        withAnimation(.linear.delay(delay)) {
            offSet = .zero
        }
    }
    
    func shouldRoundCorner() -> CGFloat {
        
        if (stringFromSchedule() == nil) {
            return .mediumCornerRadius
        } else {
            return 0
        }
    }
    
    func stringFromSchedule() -> String? {
        if let start = task.schedule.start,
           let end = task.schedule.end {
            
            let startString = timeString(from: start)
            let endString = timeString(from: end)
            
            return "\(startString) - \(endString)"
            
        } else if let start = task.schedule.start {
            return timeString(from: start)
        } else if let end = task.schedule.end {
            return timeString(from: end)
        } else {
            return nil
        }
    }
    
    func timeString(from date: Date) -> String {
        DateFormatManager.shared.timeString(from: date)
    }
}
