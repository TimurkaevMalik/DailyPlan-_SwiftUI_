//
//  Color.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 12.03.2025.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)//
        
        let a, r, g, b: UInt64 // UInt64?
        var rgbValue: UInt64 = 0
        
        Scanner(string: hex).scanHexInt64(&rgbValue) // &
        
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255,
                            (rgbValue >> 8) * 17,
                            (rgbValue >> 4 & 0xF) * 17,
                            (rgbValue & 0xF) * 17)
            
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255,
                            rgbValue >> 16,
                            rgbValue >> 8 & 0xFF,
                            rgbValue & 0xFF)
            
        case 9: // ARGB (32-bit)
            (a, r, g, b) = (rgbValue >> 24,
                            rgbValue >> 16 & 0xFF,
                            rgbValue >> 8 & 0xFF,
                            rgbValue & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(.sRGB,
                  red: Double(r) / 255,
                  green: Double(g) / 255,
                  blue: Double(b) / 255,
                  opacity: Double(a) / 255)
    }
}
