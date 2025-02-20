//
//  TaskView.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 18.08.2024.
//

import SwiftUI
///TODO: make custom popover of TaskConfigurationView
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
                .tint(.ypTomato)
                .modifier(NavBarButton(
                    color: .ypMilkDark))
        }
    }
    
    func makeMenu() -> some View {
        Menu {
            menuButton(title: "Done tasks",
                       image: Image(systemName: "checkmark.square")) {
                
                tasks = TaskInfo
                    .getTasksMock()
                    .filter({ $0.isDone == true })
            }
            
            menuButton(title: "Active tasks",
                       image: Image(systemName: "square")) {
                
                tasks = TaskInfo
                    .getTasksMock()
                    .filter({ $0.isDone == false })
            }
            
            menuButton(title: "All tasks",
                       image: Image(systemName: "list.bullet.rectangle")) {
                tasks = TaskInfo.getTasksMock()
            }
        } label: {
            Image(systemName: "slider.vertical.3")
                .tint(.ypMilkDark)
                .modifier(NavBarButton(
                    color: .ypTomato))
        }
    }
   
    func menuButton(title: String, image: Image, action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Text(title)
            image
        }
    }
}

#Preview {
    TaskView()
}
