//
//  View.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 02.02.2025.
//

import SwiftUI

extension View {
    func placeHolder<Content: View>(present: Bool, alignment: Alignment = Alignment(horizontal: .leading, vertical: .center), @ViewBuilder placeHolder: () -> Content) -> some View {
        
        ZStack(alignment: alignment) {
            placeHolder().opacity(present ? 0 : 1)
            self
        }
    }
}
