//
//  ToggleVisibilityButton.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 09.03.2025.
//

import SwiftUI

struct ToggleVisibilityButton: ViewModifier {
    
    private let buttonState: Visibility
    private let image: Image
    private let color: Color
    private let action: () -> Void
    
    init(state: Visibility,
         image: Image,
         color: Color,
         action: @escaping () -> Void) {
        self.buttonState = state
        self.image = image
        self.color = color
        self.action = action
    }
    
    func body(content: Content) -> some View {
        let width = CGSize.checkMarkButton.width
        
        
        let view = HStack(spacing: 0) {
            
            content
            
            image
                .resizable()
                .frame(width: 26, height: 26)
                .foregroundStyle(.ypGray)
                .frame(width: buttonState == .hidden ? 0 : width,
                       height: .mediumHeight)
                .clipped()
                .overlay(content: {
                    RoundedRectangle(cornerRadius: .regularCornerRadius)
                        .stroke(color)
                })
                .padding(.leading, buttonState == .hidden ? 0 : 10)
                .onTapGesture {
                    if buttonState == .visible {
                        action()
                    }
                }
        }
        
        return view
    }
}
