//
//  TaskConfigurationViewModel.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 23.02.2025.
//

import SwiftUI
import RealmSwift
import Combine

final class TaskConfigurationViewModel: ObservableObject {
    
    @Published var presentCategoriesView: Bool
    @Published var categoriesButtonState: Visibility
    
    @ObservedRealmObject var task: TaskInfo
    @Published var category: String
    @Published var categories: [String]
    
    let colors: [Color]
    private var anyCancellable: AnyCancellable?
    
    init() {
        presentCategoriesView = false
        categoriesButtonState = .visible
        
        categories = []
        colors = [.ypLightPink, .ypCyan,
                   .ypRed, .ypWarmYellow,
                   .ypGreen]
        
        category = ""
        task = .init(text: "",
                     colorHex: Color.ypWarmYellow.hexString() ?? "#F9D4D4",
                     schedule: nil,
                     isDone: false)
        
        fetchCategories()
        
//        anyCancellable = task.objectWillChange.sink{ [weak self] _ in
//            self?.objectWillChange.send()
//        }
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
