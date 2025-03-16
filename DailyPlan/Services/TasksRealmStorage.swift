//
//  TasksRealmStorage.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 16.03.2025.
//

import SwiftUI
import RealmSwift

///TODO: move to another file
protocol TasksStorageProtocol {
    func retrieveTasks() async throws -> [TaskInfo]
    func insertTask(_ task: TaskInfo) async throws
    func updateTask(_ task: TaskInfo) async throws
    func deleteTask(_ task: TaskInfo) async throws
}
///TODO: move to another file
enum ErrorMessage: String {
    case dataBaseAccessError = "Could not access data base"
    
    func message(with error: NSError) -> String {
        "\(self.rawValue). Error: \(error.code)"
    }
}

class TasksRealmStorage: TasksStorageProtocol {
    
    static var realm: Realm?
    
    init() {
        do {
            TasksRealmStorage.realm = try Realm()
        } catch let error as NSError {

            NotificationCenter.default.post(
                name: .dataBaseAccesError,
                object: ErrorMessage.dataBaseAccessError.message(with: error))
            
            TasksRealmStorage.realm = nil
        }
    }
    
    func retrieveTasks() async throws -> [TaskInfo] {
        
        
        return []
    }
    
    func insertTask(_ task: TaskInfo) async throws {
        
    }
    
    func updateTask(_ task: TaskInfo) async throws {
        
    }
    
    func deleteTask(_ task: TaskInfo) async throws {
        
    }
    
    
}
