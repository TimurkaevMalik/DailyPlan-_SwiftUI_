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
    @State private var padding: CGFloat
    @FocusState private var isFocused: Bool
    
    init(task: TaskInfo) {
        self.task = task
        descriptionViewOffSet = .zero
        padding = 6
    }
    
    var body: some View {
        HStack(alignment: .bottom, spacing: padding) {
            
            CheckMarkButton(color: task.color,
                            isDone: $task.isDone)
            .setSize(.checkMarkButton)
            
            DescriptionView(text: $task.description,
                            color: task.color,
                            focusedHeight: .large,
                            placeHolder: "Description",
                            schedule: task.schedule)
            .focused($isFocused)
            .offset(getOffSetAmount())
            .onTapGesture {
                
            }
            .gesture(dragGesture)
            .onChange(of: isFocused) {
                if isFocused {
                    withAnimation {
                        descriptionViewOffSet = .zero
                    }
                }
            }
        }
    }
    
    func getOffSetAmount() -> CGSize {
        let minWidth = 0.0
        let maxWidth = -(CGSize.checkMarkButton.width + padding)
        let currentWidth = descriptionViewOffSet.width
        
        return CGSize(width: min(minWidth, max(maxWidth, currentWidth)), height: 0)
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
                    if value.translation.width > -14 {
                        withAnimation {
                            descriptionViewOffSet = .zero
                        }
                    } else {
                        withAnimation {
                            descriptionViewOffSet.width = -(CGSize.checkMarkButton.width + padding)
                        }
                    }
                }
            }
    }
}

#Preview {
    TaskCell(task: TaskInfo(
        description: "description",
        color: .red,
        schedule: .init(start: .distantPast, end: .distantFuture),
        isDone: false))
    .padding(.horizontal)
}
