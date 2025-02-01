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

private extension TaskCell {
    func scheduleButton() -> some View {
        Button {
            
        } label: {
            if let scheduleString = stringFrom(schedule: task.schedule) {
                Text(scheduleString)
                    .padding(.horizontal, 12)
                    .tint(.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(task.color))
            }
        }
    }
    
    func checkMarkButton() -> some View {
        CheckMarkButton(color: task.color,
                        isDone: $task.isDone)
    }
    
    func customTextEditor() -> some View {
        CustomTextView(text: $task.description,
                       color: task.color,
                       focusedHeight: .large,
                         placeHolder: "Description")
    }
}

private extension TaskCell {
    func stringFrom(schedule: Schedule) -> String? {
        
        if let start = schedule.start,
           let end = schedule.end {
            
            let endString = timeStringFrom(date: end)
            let startString = timeStringFrom(date: start)
            
            return "\(startString) - \(endString)"
            
        } else if let start = schedule.start {
            return timeStringFrom(date: start)
        } else {
            return nil
        }
    }
    
    func timeStringFrom(date: Date) -> String {
        CustomDateFormatter.timeStringFrom(date: date)
    }
}

#Preview {
    TaskCell(task: Task(description: "description",
                        color: .red,
                        schedule: .init(start: .distantPast, end: .distantFuture),
                        isDone: false))
}
