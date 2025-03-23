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
    
    @Published var tasks: [TaskInfo] = [] {
        didSet {
            cancellableTasks = tasks.map {
                $0.objectWillChange.sink {
                    self.objectWillChange.send()
                }
            }
        }
    }
    
    private var cancellableTasks = [AnyCancellable]()
    private var cancellableSet = [AnyCancellable]()
    private let notification = StorageServiceNotification.shared
    private var taskStorage: TaskStorageProtocol?
    
    init() {
        taskStorage = TasksRealmStorage()
        addTaskTapped = false
        selection = Date()
        
        subscribeToTaskUpdates()
        retrieveAllTasks()
    }
    
    func allTasksFilter() {}
    
    func doneTasksFilter() {}
    
    func activeTasksFilter() {}
}

extension TasksListViewModel {
    
    func deleteTask(at index: Int) {
        withAnimation {
            tasks.remove(at: index)
        }
        
        let task = tasks[index]
        
        taskStorage?.markAsDeleted(task: task) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success:
                break
            case .failure(_):
                self.failedToDeleteTask(task)
                ///TODO: alert
            }
        }
    }
    
    private func retrieveAllTasks() {
        
        taskStorage?.retrieveTasks { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let tasks):
                self.tasks = tasks
            case .failure(let failure):
                print(failure)
                ///TODO: alert
            }
        }
    }
    
    private func didInsertTask(_ task: TaskInfo) {
        withAnimation {
            tasks.insert(task, at: 0)
        }
    }
    
    private func failedToDeleteTask(_ task: TaskInfo) {
        ///TODO: why withAnimation can not be under if statement
        withAnimation {
            tasks.insert(task, at: 0)
        }
    }
    
    private func subscribeToTaskUpdates() {
        notification.insertedTaskSubject
            .sink { task in
                self.didInsertTask(task)
            }
            .store(in: &cancellableSet)
    }
}
