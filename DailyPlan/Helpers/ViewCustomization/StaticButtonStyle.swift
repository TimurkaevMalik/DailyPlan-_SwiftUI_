//
//  StaticButtonStyle.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 03.03.2025.
//

import SwiftUI

struct StaticButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}
