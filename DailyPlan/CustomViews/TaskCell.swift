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
    @State private var deletingButtonOpacity: CGFloat
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
        deletingButtonOpacity = 1
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
            .onChange(of: isFocused) {
                if isFocused {
                    deletingButtonOpacity = 0
                } else {
                    deletingButtonOpacity = 1
                }
            }
            .background(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                    Button {
                        delete()
                    } label: {
                        trashImage()
                    }
                    .padding(.top, 20)
                    .opacity(deletingButtonOpacity)
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
    
    func showDeletingButton(
        completion: @escaping () -> Void) {
            withAnimation {
                descriptionViewOffSet.width = -(checkMarkButtonSize.width + spacing)
            } completion: {
                completion()
            }
        }
    
    func hideDeletingButton(delay: CGFloat = 0) {
        withAnimation(.linear.delay(delay)) {
            descriptionViewOffSet = .zero
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
