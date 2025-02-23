//
//  CategoryItem.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 23.02.2025.
//

import Foundation

struct CategoryItem: Equatable {
    let id = UUID()
    let title: String
    var isChosen: Bool
    
    init(title: String, isChosen: Bool = false) {
        self.title = title
        self.isChosen = isChosen
    }
    
    mutating func shouldSetChosen(_ bool: Bool) {
        isChosen = bool
    }
}
