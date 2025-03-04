//
//  DateFormatManager.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 31.01.2025.
//

import Foundation

final class DateFormatManager {
    
    static let shared = DateFormatManager()
    
    private lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateStyle = .short
        
        return formatter
    }()
    
    private init() {}
    
    func timeString(from date: Date) -> String {
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
    
    func dateString(from date: Date) -> String {
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
}
