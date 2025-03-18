//
//  TasksRealmStorage.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 16.03.2025.
//

import SwiftUI
import RealmSwift
import Combine

class TasksRealmStorage {
    
    var realmQueue: DispatchQueue
    private let notification = StorageServiceNotification.shared
    
    init() {
        realmQueue = DispatchQueue(label: "RealmQueue_Tasks",
                                   qos: .background)
    }
}

extension TasksRealmStorage: TaskStorageProtocol {
    func retrieveTasks(_ completion: @escaping (Result<[TaskInfo], ErrorRealm>) -> Void) {
        
        realmQueue.async {
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
    
    func retrieveTask(task: TaskInfo, _ completion: @escaping (TaskResult) -> Void) {
        
        realmQueue.async {
            do {
                let dataBase = try Realm()
                
                if let task = dataBase.object(ofType: TaskInfo.self,
                                              forPrimaryKey: task.id) {
                    
                    DispatchQueue.main.async {
                        completion(.success(task))
                    }
                } else {
                    completion(.failure(.taskOperationError(.retrieve)))
                }
            }  catch let error as NSError {
                completion(.failure(.dataBaseAccessError("\(error.code)")))
            }
        }
    }
    
    func insertTask(task: TaskInfo,
                    _ completion: @escaping (TaskResult) -> Void) {
        
        realmQueue.async { [weak self] in
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
        
        realmQueue.async { [weak self] in
            guard let self else { return }
            
            do {
                let dataBase = try Realm()
                try dataBase.write{}
                
                DispatchQueue.main.async {
                    self.notification.updatedTaskSubject.send(task)
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
        
        realmQueue.async { [weak self] in
            guard let self else { return }
            
            do {
                let dataBase = try Realm()
                try dataBase.write{
                    dataBase.delete(task)
                }
                
                let task = task.freeze()
                
                DispatchQueue.main.async {
                    self.notification.deletedTaskSubject.send(task)
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

///TODO: delete comments
//    func retrieveTasks() async throws(ErrorRealm) -> [TaskInfo] {
//        guard let dataBase else {
//            throw .dataBaseAccessError("unknown")
//        }
//
//        return Array(dataBase.objects(TaskInfo.self))
//    }
//
//    func insertTask(_ task: TaskInfo) async throws(ErrorRealm) {
//        guard let dataBase else {
//            throw ErrorRealm.dataBaseAccessError("unknown")
//        }
//
//        do {
//            try dataBase.write{
//                dataBase.add(task)
//            }
//        } catch let error {
//            throw ErrorRealm.taskInsertionError("\(error.localizedDescription)")
//        }
//    }
//
//    func updateTask(_ task: TaskInfo) async throws(ErrorRealm) {
////        guard let dataBase = context.dataBase() else {
////            throw .dataBaseAccessError("unknown")
////        }
//    }
//
//    func deleteTask(_ task: TaskInfo) async throws(ErrorRealm) {
////        guard let dataBase = context.dataBase() else {
////            throw .dataBaseAccessError("unknown")
////        }
//    }
