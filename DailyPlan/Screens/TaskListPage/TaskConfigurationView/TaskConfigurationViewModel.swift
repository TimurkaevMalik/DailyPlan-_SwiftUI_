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
    
    @Published var task: TaskInfo
    @Published var category: String
    @Published var categories: [String]
    
    let colors: [Color]
    
    init() {
        presentCategoriesView = false
        categoriesButtonState = .visible
        
        categories = []
        colors = [.ypLightPink, .ypCyan,
                   .ypRed, .ypWarmYellow,
                   .ypGreen]
        
        category = ""
        task = .init(description: "",
                     color: .ypWarmYellow,
                     schedule: .init(),
                     isDone: false)
        
        fetchCategories()
    }
    
    func storeNewTask() {
        print("\(category)\n\(task)")
    }
    
    func deleteCategory(at offSet: IndexSet) {
        categories.remove(atOffsets: offSet)
    }
    
    private func fetchCategories() {
        categories = ["Education", "Work",
                      "Housework", "Unnecessary"]
    }
}
