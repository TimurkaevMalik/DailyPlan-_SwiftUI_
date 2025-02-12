//
//  Fonts.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 17.08.2024.
//


import SwiftUI
///TODO: change from custom to system
extension Font {
    
    static var body: Font {
        return Font.custom("LexendDeca-Regualr", size: 14)
    }
    
    static var button: Font {
        return Font.custom("LexendDeca-SemiBold", size: 14)
    }
    
    
    static var caption: Font {
        return Font.custom("LexendDeca-Regular", size: 10)
    }
    
    static var tabBar: Font {
        return Font.custom("LexendDeca-Regular", size: 12)
    }
    
    static var settings: Font {
        return Font.custom("LexendDeca-Regular", size: 16)
    }
    
    static var title: Font {
        return Font.custom("LexendDeca-Bold", size: 23)
    }
    
    static var pageTitle: Font {
        return Font.custom("LexendDeca-SemiBold", size: 33)
    }
    
    static var taskText: Font {
        return Font.system(size: 20, weight: .semibold)
    }
}
