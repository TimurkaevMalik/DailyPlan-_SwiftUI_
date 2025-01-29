//
//  TaskCell.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 20.08.2024.
//

import SwiftUI

struct TaskCell: View {
    
    @State var task: [Task] = Task.getTasksMock()
    
    var body: some View {
        
        List(task, id: \.id ) { task in
            
            VStack(alignment: .trailing, spacing: 0) {
                
                Button {
                    print("Change timer")
                } label: {
                    
                    if let schedule = task.schedule {
                        Text(schedule)
                            .padding(.trailing, 18)
                            .tint(.black)
                            .background(RoundedRectangle(cornerRadius: 7).stroke(lineWidth: 1).padding(.trailing, 12).padding(.leading, -7))
                    }
                }
                
                HStack {
                    CheckMarkButton(color: task.color,
                                    isDone: task.isDone,
                                    size: CGSize(width: 55, height: 55)) {
                        
                        if task.isDone == true {
//                            task.isDone = false
                        } else if task.isDone == false {
//                            task.isDone = true
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
        .lineSpacing(1)
        .padding([.all], -18)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        let task = Task.getTasksMock().sorted(by: {$0.schedule ?? "" > $1.schedule ?? ""})

        TaskCell(task: task)
    }
}
