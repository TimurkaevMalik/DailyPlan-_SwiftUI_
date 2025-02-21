//
//  TaskCell.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 20.08.2024.
//

import SwiftUI

struct TaskCell: View {
    
    @State private var task: TaskInfo
    @State private var descriptionViewOffSet: CGSize
    @State private var spacing: CGFloat
    @FocusState private var isFocused: Bool
    
    private var checkMarkButtonSize: CGSize
    private let delete: () -> Void
    
    init(task: TaskInfo,
         delete: @escaping () -> Void) {
        self.task = task
        self.delete = delete
        descriptionViewOffSet = .zero
        spacing = 6
        checkMarkButtonSize = .checkMarkButton
    }
    
    var body: some View {
        HStack(alignment: .bottom, spacing: spacing) {
            
            CheckMarkButton(color: task.color,
                            isDone: $task.isDone)
            .setSize(checkMarkButtonSize)
            
            DescriptionView(text: $task.description,
                            color: task.color,
                            focusedHeight: .large,
                            placeHolder: "Description",
                            schedule: task.schedule)
            .focused($isFocused)
            .offset(getOffSetAmount())
            .gesture(dragGesture)
            .background(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
                if !isFocused {
                    Button {
                        delete()
                    } label: {
                        trashImage()
                    }
                }
            }
            .onChange(of: isFocused) {
                if isFocused {
                    withAnimation {
                        descriptionViewOffSet = .zero
                    }
                }
            }
        }
    }
}

private extension TaskCell {
    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 20, coordinateSpace: .local)
            .onChanged { value in
                if !isFocused {
                    withAnimation {
                        descriptionViewOffSet.width = value.translation.width
                    }
                }
            }
            .onEnded { value in
                if !isFocused {
                    if value.translation.width > -20 {
                        withAnimation {
                            descriptionViewOffSet = .zero
                        }
                    } else {
                        withAnimation {
                            descriptionViewOffSet.width = -(checkMarkButtonSize.width + spacing)
                        }
                    }
                }
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
        let currentWidth = descriptionViewOffSet.width
        
        return CGSize(width: min(minWidth, max(maxWidth, currentWidth)), height: 0)
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
