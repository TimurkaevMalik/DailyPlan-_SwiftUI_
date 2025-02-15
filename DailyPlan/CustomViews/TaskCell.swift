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
        HStack(alignment: .bottom, spacing: 6) {
            
            CheckMarkButton(color: task.color,
                            isDone: $task.isDone)
            .setSize(.checkMarkButton)
            
            DescriptionView(text: $task.description,
                            color: task.color,
                            focusedHeight: .large,
                            placeHolder: "Description",
                            schedule: task.schedule)
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
