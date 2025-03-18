//
//  TaskListViewModel.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 23.02.2025.
//

import SwiftUI
import Combine

final class TaskListViewModel: ObservableObject {
    
    @Published var addTaskTapped: Bool
    @Published var selection: Date
    
    @Published var visibleTasks: [TaskInfo] = []
    private var tasks: [TaskInfo] = []
    
    private var cancellableSet = [AnyCancellable]()
    private let notification = StorageServiceNotification.shared
    private let tasksStorage: TaskStorageProtocol
    
    init() {
        tasksStorage = TasksRealmStorage()
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

extension TaskListViewModel {
    private func subscribeToTaskUpdates() {
        notification.insertedTaskSubject
            .sink { task in
                self.didInsertTask(task)
            }
            .store(in: &cancellableSet)
        
        notification.updatedTaskSubject
            .sink { task in
                self.didUpdateTask(task)
            }
            .store(in: &cancellableSet)
        
        notification.deletedTaskSubject
            .sink { task in
                self.didDeleteTask(task)
            }
            .store(in: &cancellableSet)
    }
    
    private func retrieveAllTasks() {
        
        tasksStorage.retrieveTasks { result in
            switch result {
            case .success(let tasks):
                self.tasks = tasks
                self.allTasksFilter()
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    private func didInsertTask(_ task: TaskInfo) {
        visibleTasks.append(task)
    }
    
    private func didUpdateTask(_ task: TaskInfo) {}
    
    private func didDeleteTask(_ task: TaskInfo) {
        
    }
}
