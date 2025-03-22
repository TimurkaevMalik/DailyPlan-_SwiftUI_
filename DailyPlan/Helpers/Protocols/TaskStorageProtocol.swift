//
//  TaskStorageProtocol.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 17.03.2025.
//

import Foundation

protocol TaskStorageProtocol {
    typealias TaskResult = Result<Void, ErrorDataBase>
    
    func retrieveTasks(_ completion: @escaping (Result<[TaskInfo], ErrorDataBase>) -> Void)
     
    func insertTask(task: TaskInfo,
                    _ completion: @escaping (TaskResult) -> Void)
    
    func updateTask(task: TaskInfo,
                    _ completion: @escaping (TaskResult) -> Void)
    
    func markAsDone(task: TaskInfo,
                    _ completion: @escaping (TaskResult) -> Void)
    
    func markAsDeleted(task: TaskInfo,
                    _ completion: @escaping (TaskResult) -> Void)
}
