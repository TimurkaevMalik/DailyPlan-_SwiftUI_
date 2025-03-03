//
//  NavBarButton.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 20.02.2025.
//

import SwiftUI
///TODO: change type from viewModifier to ButtonStyle
struct NavBarButton: ViewModifier {
    private let color: Color
    
    init(color: Color) {
        self.color = color
    }
    
    func body(content: Content) -> some View {
        content
            .frame(width: 64, height: 34)
            .background(color)
            .font(.system(size: 16, weight: .semibold))
            .clipShape(.rect(
                cornerRadius: .regularCornerRadius))
    }
}
