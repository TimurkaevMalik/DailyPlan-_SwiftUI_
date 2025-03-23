//
//  TaskConfigurationViewModel.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 23.02.2025.
//

import SwiftUI

final class TaskConfigurationViewModel: ObservableObject {
    
    @Published var presentCategoriesView: Bool = false
    @Published var categoriesButtonState: Visibility = .visible
    
    @Published var taskText: String = ""
    @Published var category: String = ""
    @Published var categories: [String] = []
    @Published var color: Color = .ypWarmYellow
    @Published var schedule: Schedule = Schedule()
    
    let availableColors: [Color]
    private var tasksStorage: TaskStorageProtocol?
    
    init() {
        tasksStorage = TasksRealmStorage()
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
                                schedule: schedule)
            
            tasksStorage?.insertTask(task: task) { result in
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
