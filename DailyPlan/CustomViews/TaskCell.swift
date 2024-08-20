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
                }.padding(.leading, 5)
                
            
                TextContainerButton(text: task.description, color: task.color, height: 55) {
                    
                    print("Open card")
                }
                .padding(.leading, -2)
                .padding(.trailing, 10)
        }
    }
}

#Preview {
    TaskCell(task: Task(name: nil,
                        description: "Wisit my teacher at webinar, Wisit my teacher at webinar",
                        color: .orange,
                        schedule: nil,
                        isDone: false))
}
