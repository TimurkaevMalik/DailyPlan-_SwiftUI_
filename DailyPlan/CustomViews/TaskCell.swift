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
        
        HStack {
            
            CheckMarkButton(color: task.color,
                            isDone: task.isDone,
                            size: CGSize(width: 55, height: 55)) {
                
                if task.isDone == true {
                    task.isDone = false
                } else if task.isDone == false {
                    task.isDone = true
                }
                
                
                
            }
        }
    }
}

#Preview {
    TaskCell(task: Task(name: nil,
                        description: "Some description",
                        color: .orange,
                        schedule: nil,
                        isDone: false))
}
