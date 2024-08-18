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
        
        
        VStack(spacing: 0){
            
            Rectangle()
                .frame(height: 0.2)
                .tint(Color.gray)
            
            HStack {
                
                TabBarButton(action: {
                    selectedTab = .tasks
                }, imageName: "list.bullet.circle", buttonText: "Задачи", buttonColor: .iconsSecondary, isActive: selectedTab == .tasks)
                
                
                TabBarButton(action: {
                    selectedTab = .files
                }, imageName: "folder.circle", buttonText: "Задачи", buttonColor: .iconsSecondary, isActive: selectedTab == .files)
                
                TabBarButton(action: {
                    selectedTab = .settings
                }, imageName: "gearshape.circle", buttonText: "Задачи", buttonColor: .iconsSecondary, isActive: selectedTab == .settings)
                
            }
            .frame(height: 50)
        }
    }
}


#Preview {
    TabBarController(selectedTab: .constant(.tasks))
}
