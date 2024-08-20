//
//  Task.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 19.08.2024.
//

import SwiftUI

struct Task: Identifiable {
    
    let id = UUID()
    let name: String?
    let description: String
    let color: Color
    let schedule: String?
    var isDone: Bool
    
    static func getTasks() -> [Task] {
        
        [
            Task(name: "First",
                     description: "Eat food",
                     color: .blue,
                     schedule: nil,
                     isDone: true),
            
            Task(name: "Second",
                     description: "Go to school",
                     color: .orange,
                     schedule: nil,
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
                     schedule: nil,
                     isDone: true),
            
        ]
    }
}
