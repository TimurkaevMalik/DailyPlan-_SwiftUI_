//
//  TaskCategory.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 19.08.2024.
//

import Foundation
import RealmSwift

final class TaskCategory: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id = UUID()
    @Persisted var title: String
    @Persisted var tasks = RealmSwift.List<TaskInfo>()
    
    convenience init(title: String,
         tasks: [TaskInfo] = []) {
        self.init()
        self.title = title
        self.tasks.append(objectsIn: tasks)
    }
}
