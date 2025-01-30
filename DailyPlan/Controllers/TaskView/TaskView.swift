//
//  TaskView.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 18.08.2024.
//

import SwiftUI

struct TaskView: View {
    
    @State private var tasks: [Task] = {
        let array = Task.getTasksMock().sorted(by: { $0.schedule ?? ""  < $1.schedule ?? "" })
        return array
    }()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(tasks, id: \.id) { task in
                    
                    TaskCell(task: task)
                        .padding(.vertical, 10)
                        .listRowSeparator(.visible, edges: .bottom)
                    
                    if let lastTask = tasks.last,
                       lastTask.id != task.id {
                        Divider()
                    }
                }
                .padding(.top, 16)
            }
            
            .padding(.horizontal, 8)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Menu {
                        Button("Done tasks") {
                            tasks = Task.getTasksMock().filter({ $0.isDone == true }).sorted(by: { $0.schedule ?? ""  < $1.schedule ?? "" })
                        }
                        Button("Active tasks") {
                            tasks = Task.getTasksMock().filter({ $0.isDone == false }).sorted(by: { $0.schedule ?? ""  < $1.schedule ?? "" })
                        }
                        Button("All tasks") {
                            tasks = Task.getTasksMock().sorted(by: { $0.schedule ?? ""  < $1.schedule ?? "" })
                        }
                    } label: {
                        Image(systemName: "slider.vertical.3")
                            .frame(width: 70, height: 40)
                            .foregroundStyle(.ypMilkDark)
                            .background(.ypTomato)
                            .font(.system(size: 20, weight: .semibold))
                            .clipShape(.buttonBorder)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "plus")
                            .frame(width: 70, height: 40)
                            .foregroundStyle(.ypTomato)
                            .background(.ypMilkDark)
                            .font(.system(size: 20, weight: .semibold))
                            .clipShape(.buttonBorder)
                    }
                }
            }
        }
    }
    
    private let contextMenu =
        ContextMenu {
            Button {
                
            } label: {
                HStack {
                    Image(systemName: "checkmark.square")
                    Text("Done")
                }
            }
            
            Button {
                
            } label: {
                HStack {
                    Image(systemName: "cross.square")
                    Text("Done")
                }
            }
        }
}


#Preview {
    TaskView()
}
