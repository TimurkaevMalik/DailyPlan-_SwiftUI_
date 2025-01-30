//
//  TabBarView.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 17.08.2024.
//

import SwiftUI


struct TabBarView: View {
    
    @State private var selectedTab: Tabs = .tasks
    
    var body: some View {
        
        if selectedTab == .tasks {
            TaskView()
        } else if selectedTab == .files {
            FoldersView()
        } else if selectedTab == .settings {
            SettingsView()
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

private extension TabBarView {
    enum Tabs: Int {
        case tasks
        case files
        case settings
    }
}

#Preview {
    TabBarView()
}
