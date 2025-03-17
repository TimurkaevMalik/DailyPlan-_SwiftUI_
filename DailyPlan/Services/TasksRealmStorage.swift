//
//  TasksRealmStorage.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 16.03.2025.
//

import SwiftUI
import RealmSwift

class TasksRealmStorage: RealmContextProtocol {
    
    var dataBase: Realm?
    var token: NotificationToken?
    var realmQueue: DispatchQueue
    weak var delegate: TaskStorageDelegate?
    
    init(delegate: TaskStorageDelegate) {
        self.delegate = delegate
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
    
    func insertTask(task: TaskInfo, _ completion: @escaping (TaskResult) -> Void) {
        
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
                    completion(.success(task))
                }
            } catch let error {
                completion(.failure(.taskInsertionError("\(error.localizedDescription)")))
            }
        }
    }
    
    func updateTask(task: TaskInfo, _ completion: @escaping (Result<TaskInfo, ErrorRealm>) -> Void) {
        
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
                    completion(.success(task))
                }
            } catch let error {
                completion(.failure(.taskInsertionError("\(error.localizedDescription)")))
            }
        }
    }
    
    func deleteTask(task: TaskInfo, _ completion: @escaping (Result<TaskInfo, ErrorRealm>) -> Void) {
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
                    completion(.success(task))
                }
            } catch let error {
                completion(.failure(.taskInsertionError("\(error.localizedDescription)")))
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
