//
//  TabBarController.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 17.08.2024.
//

import SwiftUI

enum Tabs: Int {
    case tasks = 0
    case files = 1
    case settings = 2
}

struct TabBarController: View {
    
    @Binding var selectedTab: Tabs
    
    var body: some View {
        
        HStack {
            
            TabBarButton(action: {
                selectedTab = .tasks
            }, imageName: "list.bullet.circle", buttonText: "Задачи", buttonColor: .blue, isActive: selectedTab == .tasks)
            
            TabBarButton(action: {
                selectedTab = .files
            }, imageName: "folder.circle", buttonText: "Задачи", buttonColor: .iconsSecondary, isActive: selectedTab == .files)
            
            TabBarButton(action: {
                selectedTab = .settings
            }, imageName: "gearshape.circle", buttonText: "Задачи", buttonColor: .iconsSecondary, isActive: selectedTab == .settings)
            
        }
        .buttonStyle(PlainButtonStyle())
        .frame(height: 82)
    }
}


#Preview {
    TabBarController(selectedTab: .constant(.tasks))
}
