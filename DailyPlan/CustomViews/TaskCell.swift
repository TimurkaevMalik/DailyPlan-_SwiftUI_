//
//  TaskCell.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 20.08.2024.
//

import SwiftUI
///TODO: fix jumping behavior of scheduleView
struct TaskCell: View {
    
    @State private var task: TaskInfo
    
    @State private var cellOffSet: CGSize
    @State private var descriptionViewOffSet: CGSize
    
    @State private var isDelayedAnimationActive: Bool
    @State private var isAnimating: Bool
    @FocusState private var isFocused: Bool
    
    private let checkMarkButtonSize: CGSize
    private let spacing: CGFloat
    private let delete: () -> Void
    
    init(task: TaskInfo,
         onDelete: @escaping () -> Void) {
        self.task = task
        self.delete = onDelete
        
        cellOffSet = .zero
        descriptionViewOffSet = .zero
        
        isDelayedAnimationActive = false
        isAnimating = false
        
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
                    scheduleView(scheduleString)
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
                .background(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                    
                    if !isFocused,
                       isAnimating {
                        dismissCellButton
                    }
                }
            }
        }
        .offset(cellOffSet)
    }
}

#Preview {
    TaskCell(task: TaskInfo(
        description: "description",
        color: .ypCyan,
        schedule: .init(start: .distantPast, end: .distantFuture),
        isDone: false),
             onDelete: {})
    .padding(.horizontal)
}

private extension TaskCell {
    func scheduleView(_ schedule: String) -> some View {
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
    
    var dismissCellButton: some View {
        GeometryReader() { proxy in
            HStack {
                Spacer(minLength: 0)
                
                Button {
                    withAnimation(.linear(duration: 0.2)) {
                        cellOffSet.width = -(proxy.size.width * 1.4)
                    } completion: {
                        delete()
                    }
                    
                } label: {
                    Image(systemName: "trash")
                        .foregroundStyle(.messRed)
                        .setSize(.checkMarkButton)
                }.padding(.leading, 6)
            }
            .background {
                RoundedRectangle(cornerRadius: .mediumCornerRadius)
                    .stroke(.messRed, lineWidth: 2)
                    .clipShape(.rect(cornerRadius: .mediumCornerRadius))
            }
        }
    }
    
    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 20, coordinateSpace: .local)
            .onChanged { value in
                if !isFocused,
                   !isDelayedAnimationActive {
                    
                    isAnimating = true
                    
                    withAnimation {
                        descriptionViewOffSet.width = value.translation.width
                    }
                }
            }
            .onEnded { value in
                if !isFocused,
                   !isDelayedAnimationActive {
                    
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
}

private extension TaskCell {
    func getOffSetAmount() -> CGSize {
        let minWidth = 0.0
        let maxWidth = -(checkMarkButtonSize.width + spacing)
        let currentWidth = descriptionViewOffSet.width
        
        return CGSize(width: min(minWidth, max(maxWidth, currentWidth)), height: 0)
    }
    
    func showDeletingButton(completion: @escaping () -> Void) {
        withAnimation {
            descriptionViewOffSet.width = -(checkMarkButtonSize.width + spacing)
        } completion: {
            completion()
        }
    }
    
    func hideDeletingButton(delay: CGFloat = 0) {
        if delay > 0 {
            isDelayedAnimationActive = true
        } else {
            isDelayedAnimationActive = false
        }
        
        withAnimation(.linear.delay(delay)) {
            descriptionViewOffSet = .zero
            
        } completion: {
            isAnimating = false
            isDelayedAnimationActive = false
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
