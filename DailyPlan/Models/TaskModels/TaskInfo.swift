//
//  TaskInfo.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 19.08.2024.
//

import SwiftUI

struct TaskInfo: Identifiable {
    let id = UUID()
    var description: String
    var color: Color
    var schedule: Schedule
    var isDone: Bool
}

extension TaskInfo {
    static func getTasksMock() -> [TaskInfo] {
        [
            TaskInfo(description: "Eat food",
                     color: .ypWarmYellow,
                     schedule: Schedule(start: nil, end: .now),
                 isDone: true),
            
            TaskInfo(description: "Go to school",
                     color: .ypLightPink,
                 schedule: Schedule(start: .now, end: .now),
                 isDone: false),
            
            TaskInfo(description: "Study at school again and again till I die",
                     color: .ypGreen,
                 schedule: Schedule(start: .now, end: nil),
                 isDone: false),
            
            TaskInfo(description: "Come back from school, eat food again, do homework, build spaceship, fly to the moon",
                     color: .ypCyan,
                 schedule: Schedule(start: nil, end: nil),
                 isDone: false),
            
            TaskInfo(description: "Wash the dishes",
                     color: .ypRed,
                 schedule: Schedule(start: nil, end: .now),
                 isDone: false),
            
            TaskInfo(description: "Listen to music break the dishes",
                     color: .ypRed,
                 schedule: Schedule(start: .now, end: .now),
                 isDone: true),
            
            TaskInfo(description: "Listen to music break the dishes",
                     color: .ypRed,
                 schedule: Schedule(start: nil, end: .now),
                 isDone: true),
            
            TaskInfo(description: "Eat food",
                     color: .ypCyan,
                 schedule: Schedule(start: nil, end: nil),
                 isDone: true),
            
            TaskInfo(description: "Go to school",
                     color: .ypCyan,
                 schedule: Schedule(start: nil, end: .now),
                 isDone: false),
            
            TaskInfo(description: "Study at school again and again till I die",
                     color: .ypGreen,
                 schedule: Schedule(start: nil, end: .now),
                 isDone: false),
            
            TaskInfo(description: "Come back from school, eat food again, do homework, build spaceship, fly to the moon",
                     color: .ypLightPink,
                 schedule: Schedule(start: nil, end: nil),
                 isDone: false),
            
            TaskInfo(description: "Wash the dishes",
                 color: .ypCyan,
                 schedule: Schedule(start: .now, end: nil),
                 isDone: false),
            
            TaskInfo(description: "Listen to music break the dishes",
                 color: .ypWarmYellow,
                 schedule: Schedule(start: .now, end: nil),
                 isDone: true),
            
            TaskInfo(description: "Listen to music break the dishes",
                     color: .ypWarmYellow,
                 schedule: Schedule(start: .now, end: nil),
                 isDone: true)
        ]
    }
}
