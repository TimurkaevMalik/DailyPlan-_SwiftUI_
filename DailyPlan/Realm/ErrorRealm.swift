//
//  ErrorRealm.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 17.03.2025.
//

import Foundation

enum ErrorRealm: Error {
    case dataBaseAccessError(_ code: String = "unknown")
    case taskInsertionError(_ code: String = "unknown")
    
    var message: String {
        switch self {
        case .dataBaseAccessError(let code):
            return "Database access failed. Error: \(code)"
            
        case .taskInsertionError(let code):
            return "Task save operation failed. Error: \(code)"
        }
    }
}
