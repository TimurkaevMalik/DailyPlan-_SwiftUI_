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
    private let mainThreadRealm: Realm
    
    init?() {
        realmQueues = RealmQueue(serviceName: "TasksStorage")
        
        do {
            mainThreadRealm = try Realm()
        } catch {
            return nil
        }
        
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
                
                let tasksRef = ThreadSafeReference(to: tasks)
                
                DispatchQueue.main.async {
                    
                    if let tasksRes = self.mainThreadRealm.resolve(tasksRef) {
                        
                        completion(.success(Array(tasksRes)))
                    } else {
                        completion(.success([]))
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

                let taskRef = ThreadSafeReference(to: task)
                
                DispatchQueue.main.async {
                    
                    if let taskRes = self.mainThreadRealm.resolve(taskRef) {
                        self.notification.insertedTaskSubject.send(taskRes)
                    }
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
                
                completion(.success(Void()))
            } catch let error as NSError {
                completion(.failure(
                    .taskOperationError(.update,
                                        "\(error.code)")))
            }
        }
    }
    ///TODO: remove
    func markAsDone(task: TaskInfo, _ completion: @escaping (TaskResult) -> Void) {
//        realmQueues.userInteractive.async {
//            
//            do {
//                let dataBase = try Realm()
//                
//                if let task = task.thaw() {
//                    try dataBase.write{
//                        task.isDeleted = true
//                    }
//                    
//                    completion(.success(Void()))
//                }
//            } catch let error as NSError {
//                completion(.failure(
//                    .taskOperationError(.update,
//                                        "\(error.code)")))
//            }
//        }
    }

    func markAsDeleted(task: TaskInfo, _ completion: @escaping (TaskResult) -> Void) {
        
        let id = task._id
        
        realmQueues.userInteractive.async {
            
            do {
                let dataBase = try Realm()
                
                if let task = dataBase.object(
                    ofType: TaskInfo.self,
                    forPrimaryKey: id) {
                    
                    try dataBase.write{
                        task.isDeleted = true
                    }
                }
                
                completion(.success(Void()))
            } catch let error as NSError {
                completion(.failure(
                    .taskOperationError(.update,
                                        "\(error.code)")))
            }
        }
    }
}
