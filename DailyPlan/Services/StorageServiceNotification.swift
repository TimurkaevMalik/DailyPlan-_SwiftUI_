//
//  StorageServiceNotification.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 18.03.2025.
//

import Combine

final class StorageServiceNotification {
    static var shared = StorageServiceNotification()
    
    let insertedTaskSubject = PassthroughSubject<TaskInfo, Never>()
    let updatedTaskSubject = PassthroughSubject<TaskInfo, Never>()
    let deletedTaskSubject = PassthroughSubject<TaskInfo, Never>()
    
    private init() {}
}
