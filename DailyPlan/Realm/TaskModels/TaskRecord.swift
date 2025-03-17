//
//  TaskRecord.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 19.08.2024.
//

import Foundation
import RealmSwift

final class TaskRecord: Object, ObjectKeyIdentifiable {
    @Persisted var id: UUID
    @Persisted var date: Date
    
    convenience init(taskId: UUID,
                     date: Date) {
        self.init()
        id = taskId
        self.date = date
    }
}
