//
//  Schedule.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 31.01.2025.
//

import Foundation
import RealmSwift

final class Schedule: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id = UUID()
    @Persisted var start: Date?
    @Persisted var end: Date?
    
    convenience init(start: Date? = nil,
         end: Date? = nil) {
        self.init()
        self.start = start
        self.end = end
    }
}
