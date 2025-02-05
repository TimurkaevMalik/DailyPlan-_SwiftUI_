//
//  CustomDateFormatter.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 31.01.2025.
//

import Foundation

class CustomDateFormatter {
    
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateStyle = .short
        
        return formatter
    }()
    
    static func timeString(from date: Date) -> String {
        formatter.dateFormat = "HH:MM"
        return formatter.string(from: date)
    }
    
    static func string(from date: Date) -> String {
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
}
