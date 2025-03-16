//
//  TaskConfigurationViewModel.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 23.02.2025.
//

import SwiftUI

final class TaskConfigurationViewModel: ObservableObject {
    
    @Published var presentCategoriesView: Bool
    @Published var categoriesButtonState: Visibility
    
    @Published var taskText: String
    @Published var category: String
    @Published var categories: [String]
    @Published var color: Color
    @Published var schedule: Schedule
    
    let availableColors: [Color]
    
    init() {
        presentCategoriesView = false
        categoriesButtonState = .visible
        
        taskText = ""
        category = ""
        color = .ypWarmYellow
        schedule = Schedule()
        
        categories = []
        availableColors = [.ypLightPink,
                           .ypCyan,
                           .ypRed,
                           .ypWarmYellow,
                           .ypGreen]
        
        fetchCategories()
    }
    
    func storeNewTask() {
        if let colorHex = color.hexString() {
            let taskInfo = TaskInfo(text: taskText,
                                    colorHex: colorHex,
                                    schedule: schedule,
                                    isDone: false)
            
            print("\(category)\n\(taskInfo)")
        }
    }
    
    func deleteCategory(at offSet: IndexSet) {
        categories.remove(atOffsets: offSet)
    }
    
    private func fetchCategories() {
        categories = ["Education", "Work",
                      "Housework", "Unnecessary"]
    }
}
