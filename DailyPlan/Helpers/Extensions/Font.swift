//
//  Fonts.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 17.08.2024.
//

import SwiftUI

extension Font {
    static var caption: Font {
        return Font.system(size: 10, weight: .regular)
    }
    
    static var tabBar: Font {
        return Font.system(size: 12, weight: .regular)
    }
    
    static var body: Font {
        return Font.system(size: 14, weight: .regular)
    }
    
    static var button: Font {
        return Font.system(size: 14, weight: .semibold)
    }
    
    static var settings: Font {
        return Font.system(size: 16, weight: .regular)
    }
    
    static var taskText: Font {
        return Font.system(size: 20, weight: .regular)
    }
    
    static var title: Font {
        return Font.system(size: 24, weight: .bold)
    }
    
    static var category: Font {
        return Font.system(size: 24, weight: .regular)
    }
    
    static var pageTitle: Font {
        return Font.system(size: 34, weight: .semibold)
    }
}
