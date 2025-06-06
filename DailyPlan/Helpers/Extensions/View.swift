//
//  View.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 02.02.2025.
//

import SwiftUI

extension View {
    func setSize(_ size: CGSize) -> some View {
        modifier(ViewSize(size))
    }
    
    func setCornerRadius(_ cornerRadius: CGFloat,
                         basedOn position: ListItemPosition) -> some View {
        
        modifier(ListItemCorner(position: position, cornerRadius: cornerRadius))
    }
    
    func strokeRoundedView(stroke: BorderParameters,
                           backgroundColor: Color = .ypWhite,
                           topLeading: CGFloat = 0,
                           topTrailing: CGFloat = 0,
                           bottomLeading: CGFloat = 0,
                           bottomTrailing: CGFloat = 0) -> some View {
        
        modifier(StrokeRoundedView(
            stroke: stroke,
            backgroundColor: backgroundColor,
            topLeading: topLeading,
            topTrailing: topTrailing,
            bottomLeading: bottomLeading,
            bottomTrailing: bottomTrailing))
    }
}
