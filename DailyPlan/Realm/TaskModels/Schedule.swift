//
//  Schedule.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 31.01.2025.
//

import Foundation
import RealmSwift

final class Schedule: Object/*, ObjectKeyIdentifiable*/ {
//    @Persisted(primaryKey: true) var _id = UUID()
    @Persisted var day: Date
    @Persisted var start: Date?
    @Persisted var end: Date?
    
    convenience init(
        day: Date = Date(),
        start: Date? = nil,
        end: Date? = nil) {
            self.init()
            self.day = day
            self.start = start
            self.end = end
        }
}
