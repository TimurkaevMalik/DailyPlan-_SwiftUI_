//
//  TaskCell.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 20.08.2024.
//

import SwiftUI

struct TaskCell: View {
    
    @State var task: TaskInfo
    
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
            if let scheduleString = stringFromSchedule() {
                Text(scheduleString)
                    .padding(.horizontal, 12)
                    .tint(.ypBlack)
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
    func stringFromSchedule() -> String? {
        let schedule = task.schedule
        
        if let start = schedule.start,
           let end = schedule.end {
            
            let startString = timeString(from: start)
            let endString = timeString(from: end)
            
            return "\(startString) - \(endString)"
            
        } else if let start = schedule.start {
            return timeString(from: start)
        } else {
            return nil
        }
    }
    
    func timeString(from date: Date) -> String {
        CustomDateFormatter.timeString(from: date)
    }
}

#Preview {
    TaskCell(task: TaskInfo(description: "description",
                        color: .red,
                        schedule: .init(start: .distantPast, end: .distantFuture),
                        isDone: false))
}
