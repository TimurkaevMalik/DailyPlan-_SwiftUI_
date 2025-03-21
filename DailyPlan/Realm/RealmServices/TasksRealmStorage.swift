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
    }
}

extension TasksRealmStorage: TaskStorageProtocol {
    func retrieveTasks(_ completion: @escaping (Result<[TaskInfo], ErrorRealm>) -> Void) {
        
        realmQueues.userInteractive.async {
            do {
                let dataBase = try Realm()
                let tasks = dataBase.objects(TaskInfo.self).freeze()
                
                DispatchQueue.main.async {
                    completion(.success(Array(tasks)))
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

                let task = task.freeze()
                
                DispatchQueue.main.async {
                    self.notification.insertedTaskSubject.send(task)
                    completion(.success(task))
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
                    completion(.success(task))
                }
            } catch let error as NSError {
                completion(.failure(
                    .taskOperationError(.update,
                                        "\(error.code)")))
            }
        }
    }
    
    func deleteTask(task: TaskInfo,
                    _ completion: @escaping (TaskResult) -> Void) {
        
        realmQueues.userInteractive.async {
            
            do {
                let dataBase = try Realm()
                
                if let task = dataBase.object(
                    ofType: TaskInfo.self,
                    forPrimaryKey: task._id) {
                    
                    try dataBase.write{
                        dataBase.delete(task)
                    }
                }
                let task = task.freeze()
                
                DispatchQueue.main.async {
                    completion(.success(task))
                }
            } catch let error as NSError {
                completion(.failure(
                    .taskOperationError(.deletion,
                                        "\(error.code)")))
            }
        }
    }
}

///TODO: remove comments
//func retrieveTask(task: TaskInfo, _ completion: @escaping (TaskResult) -> Void) {
//    
//    realmQueues.backgroundQueue.async {
//        do {
//            let dataBase = try Realm()
//            
//            if let task = dataBase.object(ofType: TaskInfo.self,
//                                          forPrimaryKey: task.id) {
//                
//                DispatchQueue.main.async {
//                    completion(.success(task))
//                }
//            } else {
//                completion(.failure(.taskOperationError(.retrieve)))
//            }
//        }  catch let error as NSError {
//            completion(.failure(.dataBaseAccessError("\(error.code)")))
//        }
//    }
//}
