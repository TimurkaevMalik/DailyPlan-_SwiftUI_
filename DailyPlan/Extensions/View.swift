//
//  View.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 02.02.2025.
//

import SwiftUI

extension View {
    func placeHolder<Content: View>(present: Bool, @ViewBuilder placeHolder: () -> Content) -> some View {
        
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            placeHolder().opacity(present ? 0 : 1)
            self
        }
    }
}
