//
//  TabBarView.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 17.08.2024.
//

import SwiftUI

enum Tabs: Int {
    case tasks
    case files
    case settings
}

struct TabBarView: View {
    
    @State private var selectedTab: Tabs = .tasks
    
    var body: some View {
        
        if selectedTab == .tasks {
            TaskViewController()
        } else if selectedTab == .files {
            FilesViewController()
        } else if selectedTab == .settings {
            SettingsViewController()
        }
        
        Spacer(minLength: 0)
        
        VStack(spacing: 0) {
            
            Divider()
            
            HStack(spacing: 0) {
                TabBarButton(
                    imageName: "list.bullet.circle",
                    buttonText: "Tasks",
                    buttonColor: .iconsSecondary,
                    isActive: selectedTab == .tasks) {
                        selectedTab = .tasks
                    }
                
                TabBarButton(
                    imageName: "folder.circle",
                    buttonText: "Folders",
                    buttonColor: .iconsSecondary,
                    isActive: selectedTab == .files) {
                        selectedTab = .files
                    }
                
                TabBarButton(
                    imageName: "gearshape.circle",
                    buttonText: "Settings",
                    buttonColor: .iconsSecondary,
                    isActive: selectedTab == .settings) {
                        selectedTab = .settings
                    }
            }
        }
        .frame(height: 66)
    }
}

#Preview {
    TabBarView()
}
