//
//  StrokeRoundedView.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 18.02.2025.
//

import SwiftUI

struct StrokeRoundedView: ViewModifier {
    
    private let stroke: BorderParameters
    private let backgroundColor: Color
    private let topLeading: CGFloat
    private let topTrailing: CGFloat
    private let bottomLeading: CGFloat
    private let bottomTrailing: CGFloat
    
    init(stroke: BorderParameters,
         backgroundColor: Color = .ypWhite,
         topLeading: CGFloat = 0,
         topTrailing: CGFloat = 0,
         bottomLeading: CGFloat = 0,
         bottomTrailing: CGFloat = 0) {
        self.backgroundColor = backgroundColor
        self.stroke = stroke
        self.topLeading = topLeading
        self.topTrailing = topTrailing
        self.bottomLeading = bottomLeading
        self.bottomTrailing = bottomTrailing
    }
    
    func body(content: Content) -> some View {
        content
            .background {
                Rectangle()
                    .foregroundStyle(backgroundColor)
                    .clipShape(.rect(topLeadingRadius: topLeading, bottomLeadingRadius: bottomLeading, bottomTrailingRadius: bottomTrailing, topTrailingRadius: topTrailing))
                    .padding(.all, stroke.width)
            }
            .background {
                Rectangle()
                    .foregroundStyle(stroke.color)
                    .clipShape(.rect(topLeadingRadius: topLeading, bottomLeadingRadius: bottomLeading, bottomTrailingRadius: bottomTrailing, topTrailingRadius: topTrailing))
            }
    }
}
