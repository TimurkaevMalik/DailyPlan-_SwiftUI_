//
//  TaskStorageDelegate.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 17.03.2025.
//

import Foundation

protocol TaskStorageDelegate: AnyObject {
    func didAddTask(_ task: TaskInfo)
    func didUpdateTask(_ task: TaskInfo)
    func didDeleteTask(_ task: TaskInfo)
}
