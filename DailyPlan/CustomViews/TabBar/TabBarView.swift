//
//  TabBarView.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 17.08.2024.
//

import SwiftUI

struct TabBarView: View {
    
    @Binding private var selectedTab: Tabs
    
    init(selectedTab: Binding<Tabs>) {
        _selectedTab = selectedTab
    }
    
    var body: some View {
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
    @Previewable
    @State var selectedTab: Tabs = .tasks
    
    TabBarView(selectedTab: $selectedTab)
}
