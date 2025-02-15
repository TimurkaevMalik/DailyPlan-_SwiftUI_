//
//  TaskView.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 18.08.2024.
//

import SwiftUI

struct TaskView: View {
    
    @State private var addTaskTapped: Bool
    @State private var selection: Date
    @State private var tasks: [TaskInfo]
    
    init() {
        addTaskTapped = false
        selection = Date()
        tasks = TaskInfo.getTasksMock()
    }
    
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
                .padding(.top, .listTopPadding)
                .padding(.horizontal, 8)
            }
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $addTaskTapped) {
                TaskConfigurationView(tasks: $tasks)
                    .presentationDetents([.medium])
            }
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    makeMenu()
                }
                
                ToolbarItem(placement: .principal) {
                    PopoverDatePicker(
                        selection: $selection,
                        direction: .down)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    addTaskButton()
                }
            }
        }
    }
}

private extension TaskView {
    ///TODO: change image on next view appear
    func addTaskButton() -> some View {
        Button {
            addTaskTapped.toggle()
        } label: {
            Image(systemName: "plus")
                .frame(width: 70, height: 40)
                .foregroundStyle(.ypTomato)
                .background(.ypMilkDark)
                .font(.system(size: 20, weight: .semibold))
                .clipShape(.buttonBorder)
        }
    }
    
    func makeMenu() -> some View {
        Menu {
            doneTasksFilter()
            activeTasksFilter()
            allTasksFilter()
        } label: {
            Image(systemName: "slider.vertical.3")
                .frame(width: 70, height: 40)
                .foregroundStyle(.ypMilkDark)
                .background(.ypTomato)
                .font(.system(size: 20, weight: .semibold))
                .clipShape(.buttonBorder)
        }
    }
    
    func doneTasksFilter() -> some View {
        Button {
            tasks = TaskInfo.getTasksMock().filter({ $0.isDone == true })
        } label: {
            Image(systemName: "checkmark.square")
            Text("Done tasks")
        }
    }
    
    func activeTasksFilter() -> some View {
        Button {
            tasks = TaskInfo.getTasksMock().filter({ $0.isDone == false })
        } label: {
            Image(systemName: "square")
            Text("Active tasks")
        }
    }
    
    func allTasksFilter() -> some View {
        Button {
            tasks = TaskInfo.getTasksMock()
        } label: {
            Text("All tasks")
            Image(systemName: "list.bullet.rectangle")
        }
    }
}

#Preview {
    TaskView()
}
