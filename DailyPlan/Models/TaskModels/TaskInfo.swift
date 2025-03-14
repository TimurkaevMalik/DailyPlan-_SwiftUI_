//
//  TaskInfo.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 19.08.2024.
//

import SwiftUI
import RealmSwift


final class TaskInfo: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id = UUID()
    @Persisted var text: String
    @Persisted var schedule: Schedule?
    @Persisted var isDone: Bool
    @Persisted var colorHex: String {
        didSet {
            color = Color(hex: colorHex)
        }
    }
    
    lazy var color: Color = Color(hex: colorHex)
    
    convenience init(text: String,
         colorHex: String,
         schedule: Schedule?,
         isDone: Bool) {
        self.init()
        self.text = text
        self.colorHex = colorHex
        self.schedule = schedule
        self.isDone = isDone
        
    }
}

extension TaskInfo {
    static func getTasksMock() -> [TaskInfo] {
        [
            TaskInfo(text: "Eat food",
                     colorHex: Color.ypWarmYellow.hexString() ?? "#1A1B22",
                     schedule: Schedule(start: .now, end: .now),
                     isDone: true),
            
            TaskInfo(text: "Go to school",
                     colorHex: Color.ypLightPink.hexString() ?? "#1A1B22",
                     schedule: Schedule(start: .now, end: .now),
                     isDone: false),
            
            TaskInfo(text: "Study at school again and again till I die",
                     colorHex: Color.ypGreen.hexString() ?? "#1A1B22",
                     schedule: Schedule(start: .now, end: nil),
                     isDone: true),
            
            TaskInfo(text: "Come back from school, eat food again, do homework, build spaceship, fly to the moon",
                     colorHex: Color.ypCyan.hexString() ?? "#1A1B22",
                     schedule: Schedule(),
                     isDone: true),
            
            TaskInfo(text: "Wash the dishes",
                     colorHex: Color.ypRed.hexString() ?? "#1A1B22",
                     schedule: Schedule(),
                 isDone: false),
            
            TaskInfo(text: "Wash the dishes",
                     colorHex: Color.ypRed.hexString() ?? "#1A1B22",
                     schedule: Schedule(),
                 isDone: false),
            
            TaskInfo(text: "Wash the dishes",
                     colorHex: Color.ypRed.hexString() ?? "#1A1B22",
                     schedule: Schedule(),
                 isDone: false),
            
            TaskInfo(text: "Wash the dishes",
                     colorHex: Color.ypRed.hexString() ?? "#1A1B22",
                     schedule: Schedule(),
                 isDone: false),
            
            TaskInfo(text: "Wash the dishes",
                     colorHex: Color.ypRed.hexString() ?? "#1A1B22",
                     schedule: Schedule(),
                 isDone: false),
            
            TaskInfo(text: "Wash the dishes",
                     colorHex: Color.ypRed.hexString() ?? "#1A1B22",
                     schedule: Schedule(),
                 isDone: false),
            
            TaskInfo(text: "Wash the dishes",
                     colorHex: Color.ypRed.hexString() ?? "#1A1B22",
                     schedule: Schedule(),
                 isDone: false),
            
            TaskInfo(text: "Wash the dishes",
                     colorHex: Color.ypRed.hexString() ?? "#1A1B22",
                     schedule: Schedule(),
                 isDone: false),
            
            TaskInfo(text: "Wash the dishes",
                     colorHex: Color.ypRed.hexString() ?? "#1A1B22",
                     schedule: Schedule(),
                 isDone: false),
            
            TaskInfo(text: "Wash the dishes",
                     colorHex: Color.ypRed.hexString() ?? "#1A1B22",
                     schedule: Schedule(),
                 isDone: false)
        ]
    }
}
