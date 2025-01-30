//
//  TaskCell.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 20.08.2024.
//

import SwiftUI

struct TaskCell: View {
    
    @State var task: Task
    
    var body: some View {
        
        VStack(alignment: .trailing, spacing: 0) {
            
            scheduleButton()
                .padding(.trailing, 12)
            
            HStack(alignment: .top, spacing: 0) {
                checkMarkButton()
                customTextEditor()
                    .padding(.leading, 6)
            }
        }
    }
}

extension TaskCell {
    private func scheduleButton() -> some View {
        Button {
            print("Change timer")
        } label: {
            
            if let schedule = task.schedule {
                Text(schedule)
                    .padding(.horizontal, 12)
                    .tint(.black)
                
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(task.color)
                    )
            }
        }
    }
    
    private func checkMarkButton() -> some View {
        CheckMarkButton(color: task.color,
                        isDone: task.isDone) {
            
            if task.isDone == true {
                task.isDone = false
            } else if task.isDone == false {
                task.isDone = true
            }
        }
    }
    
    private func customTextEditor() -> some View {
        CustomTextEditor(text: task.description,
                         color: task.color)
    }
}

#Preview {
    TaskCell(task: Task(name: "name",
                        description: "description",
                        color: .red,
                        schedule: "12:00",
                        isDone: false))
}
