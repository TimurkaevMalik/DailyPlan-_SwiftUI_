//
//  ListItemCorner.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 13.02.2025.
//

import SwiftUI

struct ListItemCorner: ViewModifier {
    private let position: ListItemPosition
    private let cornerRadius: CGFloat
    
    init(position: ListItemPosition, cornerRadius: CGFloat) {
        self.position = position
        self.cornerRadius = cornerRadius
    }
    
    func body(content: Content) -> some View {
        content
            .clipShape(setShapes())
    }
    
    private func setShapes() -> UnevenRoundedRectangle {
        switch position {
        case .first:
            return .rect(
                topLeadingRadius: cornerRadius,
                topTrailingRadius: cornerRadius)
            
        case .last:
            return .rect(
                bottomLeadingRadius: cornerRadius,
                bottomTrailingRadius: cornerRadius)
            
        case .single:
            return .rect(topLeadingRadius: cornerRadius,
                         bottomLeadingRadius: cornerRadius,
                         bottomTrailingRadius: cornerRadius,
                         topTrailingRadius: cornerRadius)
        case ._default:
            return .rect(
                topLeadingRadius: 0,
                bottomLeadingRadius: 0,
                bottomTrailingRadius: 0,
                topTrailingRadius: 0)
        }
    }
}
