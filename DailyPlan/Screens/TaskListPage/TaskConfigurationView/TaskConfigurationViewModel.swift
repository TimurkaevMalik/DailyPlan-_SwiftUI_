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
    private lazy var tasksStorage: TaskStorageProtocol = TasksRealmStorage(delegate: nil)
    
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
    
    func insertNewTask() {
        if let colorHex = color.hexString() {
            let task = TaskInfo(text: taskText,
                                colorHex: colorHex,
                                schedule: schedule,
                                isDone: false)
            
            tasksStorage.insertTask(task: task) { result in
                switch result {
                case .success:
                    break
                case .failure(let failure):
                    print(failure)
                    ///TODO: show alert
                }
            }
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
