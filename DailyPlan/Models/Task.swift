//
//  Task.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 19.08.2024.
//

import SwiftUI

struct Task: Identifiable {
    let id = UUID()
    var description: String
    var color: Color
    var schedule: Schedule
    var isDone: Bool
}

extension Task {
    static func getTasksMock() -> [Task] {
        [
            Task(description: "Eat food",
                 color: .blue,
                 schedule: Schedule(start: .now, end: .now),
                 isDone: true),
            
            Task(description: "Go to school",
                 color: .orange,
                 schedule: Schedule(start: .now, end: .now),
                 isDone: false),
            
            Task(description: "Study at school again and again till I die",
                 color: .purple,
                 schedule: Schedule(start: .now, end: nil),
                 isDone: false),
            
            Task(description: "Come back from school, eat food again, do homework, build spaceship, fly to the moon",
                 color: .green,
                 schedule: Schedule(start: nil, end: nil),
                 isDone: false),
            
            Task(description: "Wash the dishes",
                 color: .cyan,
                 schedule: Schedule(start: nil, end: .now),
                 isDone: false),
            
            Task(description: "Lesten to music break the dishes",
                 color: .accentColor,
                 schedule: Schedule(start: .now, end: .now),
                 isDone: true),
            
            Task(description: "Lesten to music break the dishes",
                 color: .accentColor,
                 schedule: Schedule(start: nil, end: .now),
                 isDone: true),
            
            Task(description: "Eat food",
                 color: .blue,
                 schedule: Schedule(start: nil, end: nil),
                 isDone: true),
            
            Task(description: "Go to school",
                 color: .orange,
                 schedule: Schedule(start: nil, end: .now),
                 isDone: false),
            
            Task(description: "Study at school again and again till I die",
                 color: .purple,
                 schedule: Schedule(start: nil, end: .now),
                 isDone: false),
            
            Task(description: "Come back from school, eat food again, do homework, build spaceship, fly to the moon",
                 color: .green,
                 schedule: Schedule(start: nil, end: nil),
                 isDone: false),
            
            Task(description: "Wash the dishes",
                 color: .cyan,
                 schedule: Schedule(start: .now, end: nil),
                 isDone: false),
            
            Task(description: "Lesten to music break the dishes",
                 color: .accentColor,
                 schedule: Schedule(start: .now, end: nil),
                 isDone: true),
            
            Task(description: "Lesten to music break the dishes",
                 color: .accentColor,
                 schedule: Schedule(start: .now, end: nil),
                 isDone: true)
        ]
    }
}
