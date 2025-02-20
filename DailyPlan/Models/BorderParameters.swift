//
//  BorderParameters.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 18.02.2025.
//

import SwiftUI

struct BorderParameters {
    let width: CGFloat
    let color: Color
    
    init(width: CGFloat = 1, color: Color) {
        self.width = width
        self.color = color
    }
}

extension BorderParameters {
    static func style(width: CGFloat = 1, color: Color) -> BorderParameters {
        BorderParameters(width: width, color: color)
    }
}
