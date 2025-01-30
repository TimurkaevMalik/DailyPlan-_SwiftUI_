//
//  Task.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 19.08.2024.
//

import SwiftUI

struct Task: Identifiable {
    
    let id = UUID()
    var name: String?
    var description: String
    var color: Color
    var schedule: String?
    var isDone: Bool
    
    static func getTasksMock() -> [Task] {
        
        [
            Task(name: "First",
                     description: "Eat food",
                     color: .blue,
                     schedule: "17:00 - 18:00",
                     isDone: true),
            
            Task(name: "Second",
                     description: "Go to school",
                     color: .orange,
                     schedule: "17:00 - 18:00",
                     isDone: false),
            
            Task(name: nil,
                     description: "Study at school again and again till I die",
                     color: .purple,
                     schedule: nil,
                     isDone: false),
            
            Task(name: nil,
                     description: "Come back from school, eat food again, do homework, build spaceship, fly to the moon",
                     color: .green,
                     schedule: nil,
                     isDone: false),
            
            Task(name: "Dishes",
                     description: "Wash the dishes",
                     color: .cyan,
                     schedule: nil,
                     isDone: false),
            
            Task(name: "Break the dishes",
                     description: "Lesten to music break the dishes",
                     color: .accentColor,
                     schedule: "17:00 - 18:00",
                     isDone: true),
            
            Task(name: "Break the dishes",
                     description: "Lesten to music break the dishes",
                     color: .accentColor,
                     schedule: "17:00 - 18:00",
                     isDone: true),
            
            Task(name: "First",
                     description: "Eat food",
                     color: .blue,
                     schedule: "17:00 - 18:00",
                     isDone: true),
            
            Task(name: "Second",
                     description: "Go to school",
                     color: .orange,
                     schedule: "17:00 - 18:00",
                     isDone: false),
            
            Task(name: nil,
                     description: "Study at school again and again till I die",
                     color: .purple,
                     schedule: nil,
                     isDone: false),
            
            Task(name: nil,
                     description: "Come back from school, eat food again, do homework, build spaceship, fly to the moon",
                     color: .green,
                     schedule: nil,
                     isDone: false),
            
            Task(name: "Dishes",
                     description: "Wash the dishes",
                     color: .cyan,
                     schedule: nil,
                     isDone: false),
            
            Task(name: "Break the dishes",
                     description: "Lesten to music break the dishes",
                     color: .accentColor,
                     schedule: "17:00 - 18:00",
                     isDone: true),
            
            Task(name: "Break the dishes",
                     description: "Lesten to music break the dishes",
                     color: .accentColor,
                     schedule: "17:00 - 18:00",
                     isDone: true)
        ]
    }
}
