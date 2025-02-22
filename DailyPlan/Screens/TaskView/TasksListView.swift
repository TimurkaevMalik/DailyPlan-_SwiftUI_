//
//  TasksListView.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 18.08.2024.
//

import SwiftUI
///TODO: make custom popover of TaskConfigurationView
struct TasksListView: View {
    
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
                    
                    TaskCell(task: task) {
                            delete(task: task)
                    }
                    .padding(.vertical, 12)
                    .overlay(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
                        if let lastTask = tasks.last,
                           lastTask.id != task.id {
                            dividerView
                        }
                    }
                }
                .padding(.top, .mediumSpacing)
                .padding(.horizontal, .screenHorizontalSpacing)
            }
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $addTaskTapped) {
                TaskConfigurationView(tasks: $tasks)
                    .presentationDetents([.medium])
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    menuButton
                }
                
                ToolbarItem(placement: .principal) {
                    PopoverDatePicker(
                        selection: $selection,
                        direction: .down)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    newTaskButton
                }
            }
        }
    }
}

#Preview {
    TasksListView()
}

private extension TasksListView {
    var dividerView: some View {
        Divider()
            .padding(.leading, CGSize.checkMarkButton.width + CGFloat.defaultSpacing)
    }
    ///TODO: change image on next view appear
    var newTaskButton: some View {
        Button {
            addTaskTapped.toggle()
        } label: {
            Image(systemName: "plus")
                .tint(.ypTomato)
                .modifier(NavBarButton(
                    color: .ypMilkDark))
        }
    }
    
    var menuButton: some View {
        Menu {
            menuItemButton(title: "Done tasks",
                           image: Image(systemName: "checkmark.square")) {
                tasks = TaskInfo
                    .getTasksMock()
                    .filter({ $0.isDone == true })
            }
            
            menuItemButton(title: "Active tasks",
                           image: Image(systemName: "square")) {
                
                tasks = TaskInfo
                    .getTasksMock()
                    .filter({ $0.isDone == false })
            }
            
            menuItemButton(title: "All tasks",
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
    
    func menuItemButton(title: String, image: Image, action: @escaping () -> Void) -> some View {
        
        Button {
            action()
        } label: {
            Text(title)
            image
        }
    }
}

private extension TasksListView {
    func delete(task: TaskInfo) {
        withAnimation {
            if let index = tasks.firstIndex(where: { $0.id == task.id }) {
                tasks.remove(at: index)
            }
        }
    }
}
