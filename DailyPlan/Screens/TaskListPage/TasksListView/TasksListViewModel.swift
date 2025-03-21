//
//  TaskListViewModel.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 23.02.2025.
//

import SwiftUI
import Combine

final class TasksListViewModel: ObservableObject {
    
    @Published var addTaskTapped: Bool
    @Published var selection: Date
    
    @Published var visibleTasks: [TaskInfo] = []
    private var tasks: [TaskInfo] = []
    
    private var cancellableSet = [AnyCancellable]()
    private let notification = StorageServiceNotification.shared
    private let taskStorage: TaskStorageProtocol
    
    init() {
        taskStorage = TasksRealmStorage()
        addTaskTapped = false
        selection = Date()
        
        subscribeToTaskUpdates()
        retrieveAllTasks()
    }

    func delete(task: TaskInfo) {
        withAnimation {
        if let index = visibleTasks.firstIndex(where: { $0.id == task.id }) {
                visibleTasks.remove(at: index)
            }
        }
        
        taskStorage.deleteTask(task: task) { result in ///[weak self]??
            switch result {
            case .success(let task):
                self.didDeleteTask(task)
            case .failure(_):
                self.failedToDeleteTask(task)
                ///TODO: alert
            }
        }
    }
    
    func allTasksFilter() {
        visibleTasks = tasks
    }
    
    func doneTasksFilter() {
        visibleTasks = tasks.filter({ $0.isDone == true })
    }
    
    func activeTasksFilter() {
        visibleTasks = tasks.filter({ $0.isDone == false })
    }
}

extension TasksListViewModel {
    private func subscribeToTaskUpdates() {
        notification.insertedTaskSubject
            .sink { task in
                self.didInsertTask(task)
            }
            .store(in: &cancellableSet)
    }
    
    private func retrieveAllTasks() {
        
        taskStorage.retrieveTasks { result in
            switch result {
            case .success(let tasks):
                self.tasks = tasks
                self.allTasksFilter()
            case .failure(let failure):
                print(failure)
                ///TODO: alert
            }
        }
    }
    
    private func didInsertTask(_ task: TaskInfo) {
        withAnimation {
            visibleTasks.insert(task, at: 0)
        }
    }
    
    private func didUpdateTask(_ task: TaskInfo) {}
    
    private func didDeleteTask(_ task: TaskInfo) {
        ///TODO: why withAnimation can not be under if statement
        withAnimation {
        if let index = visibleTasks.firstIndex(where: { $0.id == task.id }) {
                visibleTasks.remove(at: index)
            }
        }
    }
    
    private func failedToDeleteTask(_ task: TaskInfo) {
        ///TODO: why withAnimation can not be under if statement
        withAnimation {
            tasks.insert(task, at: 0)
        }
    }
}
