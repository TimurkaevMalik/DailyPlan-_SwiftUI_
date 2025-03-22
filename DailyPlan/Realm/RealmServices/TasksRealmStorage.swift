//
//  TasksRealmStorage.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 16.03.2025.
//

import SwiftUI
import RealmSwift

final class TasksRealmStorage {
    
    private let notification = StorageServiceNotification.shared
    private let realmQueues: RealmQueue
    
    init() {
        realmQueues = RealmQueue(serviceName: "TasksStorage")
        
        deleteMarkedTasks() { result in
            switch result {
            case .success:
                break
            case .failure:
                break
            }
        }
    }
    
    private func deleteMarkedTasks(_ completion: @escaping (Result<Void, ErrorDataBase>) -> Void) {
        
        realmQueues.userInteractive.async {
            
            do {
                let dataBase = try Realm()
                let predicate = "isDeleted == 1"
                
                let tasks = dataBase.objects(TaskInfo.self).filter(predicate)
                
                    try dataBase.write{
                        dataBase.delete(tasks)
                    }
                
                completion(.success(Void()))
            } catch let error as NSError {
                completion(.failure(
                    .taskOperationError(.deletion,
                                        "\(error.code)")))
            }
        }
    }
}

extension TasksRealmStorage: TaskStorageProtocol {
    func retrieveTasks(_ completion: @escaping (Result<[TaskInfo], ErrorDataBase>) -> Void) {
        
        realmQueues.userInteractive.async {
            do {
                let dataBase = try Realm()
                let predicate = "isDeleted == 0"
                let tasks = dataBase.objects(TaskInfo.self).filter(predicate)
                
                let ref = ThreadSafeReference(to: tasks)
                DispatchQueue.main.async {
                    do {
                        let dataBase = try Realm()
                        if let res = dataBase.resolve(ref) {
                            completion(.success(Array(res)))
                        }
                    } catch {
                        completion(.failure(.dataBaseAccessError()))
                    }
                }
            } catch let error as NSError {
                completion(.failure(.dataBaseAccessError("\(error.code)")))
            }
        }
    }
    
    func insertTask(task: TaskInfo,
                    _ completion: @escaping (TaskResult) -> Void) {
        
        realmQueues.userInteractive.async { [weak self] in
            guard let self else { return }
            
            do {
                let dataBase = try Realm()
                
                try dataBase.write {
                    dataBase.add(task)
                }
                let frozenTask = task.freeze()
                
                DispatchQueue.main.async {
                    self.notification.insertedTaskSubject.send(frozenTask)
                    completion(.success(Void()))
                }
            } catch let error as NSError {
                completion(.failure(
                    .taskOperationError(.insertion,
                                        "\(error.code)")))
            }
        }
    }
    
    func updateTask(task: TaskInfo,
                    _ completion: @escaping (TaskResult) -> Void) {
        
        realmQueues.userInteractive.async {
            
            do {
                let dataBase = try Realm()
                try dataBase.write{}
                
                DispatchQueue.main.async {
                    completion(.success(Void()))
                }
            } catch let error as NSError {
                completion(.failure(
                    .taskOperationError(.update,
                                        "\(error.code)")))
            }
        }
    }
    
    func markAsDone(task: TaskInfo, _ completion: @escaping (TaskResult) -> Void) {
        realmQueues.userInteractive.async {
            
            do {
                let dataBase = try Realm()
                if let task = task.thaw() {
                    try dataBase.write{
                        
                        task.isDeleted = true
                    }
                    
                    DispatchQueue.main.async {
                        completion(.success(Void()))
                    }
                }
            } catch let error as NSError {
                completion(.failure(
                    .taskOperationError(.update,
                                        "\(error.code)")))
            }
        }
    }

    func markAsDeleted(task: TaskInfo, _ completion: @escaping (TaskResult) -> Void) {
        realmQueues.userInteractive.async {
            
            do {
                let dataBase = try Realm()
                
                if let task = task.thaw() {
                    try dataBase.write{
                        
                        task.isDeleted = true
                    }
                    
                    DispatchQueue.main.async {
                        completion(.success(Void()))
                    }
                }
            } catch let error as NSError {
                completion(.failure(
                    .taskOperationError(.update,
                                        "\(error.code)")))
            }
        }
    }
}
