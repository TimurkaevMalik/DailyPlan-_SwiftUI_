//
//  TaskCell.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 20.08.2024.
//

import SwiftUI

struct TaskCell: View {
    
    @State private var task: TaskInfo
    
    @State private var cellOffSet: CGSize
    @State private var descriptionViewOffSet: CGSize
    ///TODO: remove isDelayedAnimationActive
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
                    text: $task.text,
                    color: .clear,
                    focusedHeight: .large,
                    placeHolder: "Description")
                .strokeRoundedView(
                    stroke: .style(color: task.color),
                    topLeading: .regularCornerRadius,
                    topTrailing: shouldRoundCorner(),
                    bottomLeading: .regularCornerRadius,
                    bottomTrailing: .regularCornerRadius)
                .focused($isFocused)
                .offset(getOffSetAmount())
                .gesture(dragGesture)
                .background(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                    
                    if !isFocused,
                       isAnimating {
                        cellDismissingButton
                    }
                }
            }
        }
        .offset(cellOffSet)
    }
}

#if DEBUG
#Preview {
    TaskCell(task: TaskInfo(
        text: "description",
        colorHex: Color.ypCyan.hexString() ?? "#1A1B22",
        schedule: .init(start: .distantPast,
                        end: .distantFuture),
        isDone: false),
             onDelete: {})
    .padding(.horizontal)
}
#endif

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
    
    var cellDismissingButton: some View {
        GeometryReader() { proxy in
            HStack {
                Spacer(minLength: 0)
                
                Button {
                    withAnimation(.linear(duration: 0.2)) {
                        cellOffSet.width = -(proxy.size.width * 1.4)
                    } completion: {
                        
                        delete()
                        
                        ///TODO: remove hideDismissingButton()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            hideDismissingButton()
                            cellOffSet.width = .zero
                        }
                    }
                    
                } label: {
                    Image(systemName: "trash")
                        .foregroundStyle(.messRed)
                        .setSize(.checkMarkButton)
                }.padding(.leading, 6)
            }
            .background {
                RoundedRectangle(cornerRadius: .regularCornerRadius)
                    .stroke(.messRed, lineWidth: 2)
                    .clipShape(.rect(cornerRadius: .regularCornerRadius))
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
                        
                        hideDismissingButton()
                    } else {
                        showDeletingButton(completion: {
                            hideDismissingButton(delay: 2)
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
    
    func hideDismissingButton(delay: CGFloat = 0) {
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
            return .regularCornerRadius
        } else {
            return 0
        }
    }
    
    func stringFromSchedule() -> String? {
        if let start = task.schedule?.start,
           let end = task.schedule?.end {
            
            let startString = timeString(from: start)
            let endString = timeString(from: end)
            
            return "\(startString) - \(endString)"
            
        } else if let start = task.schedule?.start {
            return timeString(from: start)
        } else if let end = task.schedule?.end {
            return timeString(from: end)
        } else {
            return nil
        }
    }
    
    func timeString(from date: Date) -> String {
        DateFormatManager.shared.timeString(from: date)
    }
}
