//
//  Date.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 12.02.2025.
//

import Foundation

extension Date {
    func get(_ component: Calendar.Component, calendar: Calendar = .current) -> Int {
        return calendar.component(component, from: self)
    }
}
