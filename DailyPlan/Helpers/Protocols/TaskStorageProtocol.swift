//
//  TaskStorageProtocol.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 17.03.2025.
//

import Foundation

protocol TaskStorageProtocol {
    typealias TaskResult = Result<TaskInfo, ErrorRealm>
    
    func retrieveTasks(_ completion: @escaping (Result<[TaskInfo], ErrorRealm>) -> Void)
     
    func insertTask(task: TaskInfo,
                    _ completion: @escaping (TaskResult) -> Void)
    
    func updateTask(task: TaskInfo,
                    _ completion: @escaping (TaskResult) -> Void)
    
    func deleteTask(task: TaskInfo,
                    _ completion: @escaping (TaskResult) -> Void)
}


///TODO: delete comments
//    func retrieveTasks() async throws(ErrorRealm) -> [TaskInfo]
//    func insertTask(_ task: TaskInfo, ) async throws(ErrorRealm)
//    func updateTask(_ task: TaskInfo) async throws(ErrorRealm)
//    func deleteTask(_ task: TaskInfo) async throws(ErrorRealm)
