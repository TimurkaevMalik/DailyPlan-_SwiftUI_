//
//  TaskCell.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 19.08.2024.
//

import SwiftUI

struct TaskCell {
    
    let id = UUID()
    let name: String?
    let description: String
    let color: Color
    let schedule: String?
    let isDone: Bool
    
    static func getTasks() -> [TaskCell] {
        
        [
            TaskCell(name: "First",
                     description: "Eat food",
                     color: .blue,
                     schedule: nil,
                     isDone: true),
            
            TaskCell(name: "Second",
                     description: "Go to school",
                     color: .orange,
                     schedule: nil,
                     isDone: false),
            
            TaskCell(name: nil,
                     description: "Study at school again and again till I die",
                     color: .purple,
                     schedule: nil,
                     isDone: false),
            
            TaskCell(name: nil,
                     description: "Come back from school, eat food again, do homework, build spaceship, fly to the moon",
                     color: .green,
                     schedule: nil,
                     isDone: false),
            
            TaskCell(name: "Dishes",
                     description: "Wash the dishes",
                     color: .cyan,
                     schedule: nil,
                     isDone: false),
            
            TaskCell(name: "Break the dishes",
                     description: "Lesten to music break the dishes",
                     color: .accentColor,
                     schedule: nil,
                     isDone: true),
            
        ]
    }
}
