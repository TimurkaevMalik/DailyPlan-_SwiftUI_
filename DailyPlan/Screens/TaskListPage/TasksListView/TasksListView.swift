//
//  TasksListView.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 18.08.2024.
//

import SwiftUI
///TODO: make custom popover of TaskConfigurationView
struct TasksListView: View {
    
    @StateObject private var vm = TaskListViewModel()
    
    init() {}
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(vm.tasks, id: \.id) { task in
                    
                    TaskCell(task: task) {
                        vm.delete(task: task)
                    }
                    .padding(.vertical, 12)
                    .overlay(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
                        if let lastTask = vm.tasks.last,
                           lastTask.id != task.id {
                            dividerView
                        }
                    }
                }
                .padding(.top, .mediumSpacing)
                .padding(.horizontal, .screenHorizontalSpacing)
            }
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $vm.addTaskTapped) {
                TaskConfigurationView()
                    .presentationDetents([.medium])
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    menuButton
                }
                
                ToolbarItem(placement: .principal) {
                    PopoverDatePicker(
                        selection: $vm.selection,
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
            vm.addTaskTapped.toggle()
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
                vm.doneTasksFilter()
            }
            
            menuItemButton(title: "Active tasks",
                           image: Image(systemName: "square")) {
                vm.activeTasksFilter()
            }
            
            menuItemButton(title: "All tasks",
                           image: Image(systemName: "list.bullet.rectangle")) {
                vm.allTasksFilter()
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
