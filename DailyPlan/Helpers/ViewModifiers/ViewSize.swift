//
//  ViewSize.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 12.02.2025.
//

import SwiftUI

struct ViewSize: ViewModifier {
    
    let size: CGSize
    
    init(_ size: CGSize) {
        self.size = size
    }
    
    func body(content: Content) -> some View {
        content
            .frame(width: size.width, height: size.height)
    }
}
