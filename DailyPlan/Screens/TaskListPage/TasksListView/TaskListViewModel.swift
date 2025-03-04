//
//  TaskListViewModel.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 23.02.2025.
//

import SwiftUI

final class TaskListViewModel: ObservableObject {
    
    @Published var tasks: [TaskInfo]
    @Published var addTaskTapped: Bool
    @Published var selection: Date
    
    private var allTasks: [TaskInfo]
    
    init() {
        addTaskTapped = false
        selection = Date()
        allTasks = []
        tasks = []
        getAllTasks()
        allTasksFilter()
    }
}

extension TaskListViewModel {
    func delete(task: TaskInfo) {
        withAnimation {
            if let index = tasks.firstIndex(where: { $0.id == task.id }) {
                tasks.remove(at: index)
            }
        }
    }
    
    func allTasksFilter() {
        tasks = allTasks
    }
    
    func doneTasksFilter() {
        print(allTasks.count)
        tasks = allTasks.filter({ $0.isDone == true })
        
        print(allTasks.count)
    }
    
    func activeTasksFilter() {
        tasks = allTasks.filter({ $0.isDone == false })
    }
    
    private func getAllTasks() {
        allTasks = TaskInfo
            .getTasksMock()
    }
}
