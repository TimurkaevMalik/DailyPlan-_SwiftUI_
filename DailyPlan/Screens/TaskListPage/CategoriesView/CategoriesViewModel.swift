//
//  CategoriesViewModel.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 23.02.2025.
//

import SwiftUI

final class CategoriesViewModel: ObservableObject {
    @Environment(\.dismiss) var dismiss
    @Published var color: Color
    @Published var category: String
    @Published var categories: [CategoryItem]
    
    init() {
        color = .ypGreen
        category = ""
        categories = []
        fetchCategories()
    }
}

extension CategoriesViewModel {
    func deleteItem(at offSet: IndexSet) {
        withAnimation {
            categories.remove(atOffsets: offSet)
        }
    }
    
    func setLastChosenCategory() {
        categories.indices.forEach({
            categories[$0].shouldSetChosen(
                category.lowercased() == categories[$0].title.lowercased())
        })
    }
    
    private func fetchCategories() {
        let categories = ["Education", "Work",
                      "Housework", "Unnecessary"]
        
        categories.forEach({
            self.categories.append(.init(title: $0 ))
        })
    }
}
