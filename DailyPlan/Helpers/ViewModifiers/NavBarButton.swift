//
//  NavBarButton.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 20.02.2025.
//

import SwiftUI

struct NavBarButton: ViewModifier {
    private let color: Color
    
    init(color: Color) {
        self.color = color
    }
    
    func body(content: Content) -> some View {
        content
            .frame(width: 70, height: 40)
            .background(color)
            .font(.system(size: 20, weight: .semibold))
            .clipShape(.rect(
                cornerRadius: .mediumCornerRadius))
    }
}
