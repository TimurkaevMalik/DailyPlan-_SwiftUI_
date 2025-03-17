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
    private lazy var tasksStorage: TaskStorageProtocol = TasksRealmStorage(delegate: self)
    
    init() {
        addTaskTapped = false
        selection = Date()
        allTasks = []
        tasks = []
        
        retrieveAllTasks()
    }

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
        tasks = allTasks.filter({ $0.isDone == true })
    }
    
    func activeTasksFilter() {
        tasks = allTasks.filter({ $0.isDone == false })
    }
    
    private func retrieveAllTasks() {
        
        tasksStorage.retrieveTasks { result in
            switch result {
            case .success(let tasks):
                self.allTasks = tasks
                self.allTasksFilter()
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

extension TaskListViewModel: TaskStorageDelegate {
    func didAddTask(_ task: TaskInfo) {
        
    }
    
    func didUpdateTask(_ task: TaskInfo) {
        
    }
    
    func didDeleteTask(_ task: TaskInfo) {
        
    }
}
