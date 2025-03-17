//
//  TasksRealmStorage.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 16.03.2025.
//

import SwiftUI
import RealmSwift
import Combine

class StorageServiceNotification {
    static var shared = StorageServiceNotification()
    
    let insertedTaskSubject = PassthroughSubject<TaskInfo, Never>()
    let updatedTaskSubject = PassthroughSubject<TaskInfo, Never>()
    let deletedTaskSubject = PassthroughSubject<TaskInfo, Never>()
    
    private init() {}
}

class TasksRealmStorage: RealmContextProtocol {
    
    var dataBase: Realm?
    var realmQueue: DispatchQueue
    weak var delegate: TaskStorageDelegate?
    private let notification: StorageServiceNotification
    
    init(delegate: TaskStorageDelegate?) {
        self.delegate = delegate
        notification = StorageServiceNotification.shared
        realmQueue = DispatchQueue(label: "RealmQueue_Tasks",
                                   qos: .background)
        
        getRealm { result in
            switch result {
                
            case .success(let dataBase):
                self.dataBase = dataBase
                
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

extension TasksRealmStorage: TaskStorageProtocol {
    func retrieveTasks(_ completion: @escaping (Result<[TaskInfo], ErrorRealm>) -> Void) {
        realmQueue.async { [weak self] in
            guard
                let self,
                let dataBase = self.dataBase
            else {
                completion(.failure(.dataBaseAccessError()))
                return
            }

            do {
                let tasks = dataBase.objects(TaskInfo.self).freeze()
                
                DispatchQueue.main.async {
                    completion(.success(Array(tasks)))
                }
            }
        }
    }
    
    func retrieveTask(task: TaskInfo, _ completion: @escaping (TaskResult) -> Void) {
        realmQueue.async { [weak self] in
            guard
                let self,
                let dataBase = self.dataBase
            else {
                completion(.failure(.dataBaseAccessError()))
                return
            }

            do {
                if let task = dataBase.object(ofType: TaskInfo.self,
                                                  forPrimaryKey: task.id) {
                    
                    DispatchQueue.main.async {
                        completion(.success(task))
                    }
                } else {
                    completion(.failure(.taskOperationError(.retrieve)))
                }
            }
        }
    }
    
    func insertTask(task: TaskInfo,
                    _ completion: @escaping (TaskResult) -> Void) {
        
        realmQueue.async { [weak self] in
            guard
                let self,
                let dataBase = self.dataBase
            else {
                completion(.failure(.dataBaseAccessError()))
                return
            }
            
            do {
                try dataBase.write{
                    dataBase.add(task)
                }
                
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
            guard
                let self,
                let dataBase = self.dataBase
            else {
                completion(.failure(.dataBaseAccessError()))
                return
            }
            
            do {
                try dataBase.write{
                    dataBase.add(task)
                }
                
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
            guard
                let self,
                let dataBase = self.dataBase
            else {
                completion(.failure(.dataBaseAccessError()))
                return
            }
            
            do {
                try dataBase.write{
                    dataBase.add(task)
                }
                
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
