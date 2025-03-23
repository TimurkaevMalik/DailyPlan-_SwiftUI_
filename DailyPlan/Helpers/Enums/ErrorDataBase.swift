//
//  ErrorRealm.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 17.03.2025.
//

import Foundation

enum ErrorDataBase: Error {
    ///TODO: add while/type operation for dataBaseAccessError
    case dataBaseAccessError(_ code: String = "unknown")
    case taskOperationError(_ type: TaskOperationType,
                            _ code: String = "unknown")
    
    var message: String {
        switch self {
        case .dataBaseAccessError(let code):
            "Database access failed. Error: \(code)"
           
        case .taskOperationError(let type, let code):
            "Task \(type.rawValue) operation failed. Error: \(code)"
        }
    }
    
    enum TaskOperationType: String {
        case insertion
        case retrieve
        case deletion
        case update
    }
}
