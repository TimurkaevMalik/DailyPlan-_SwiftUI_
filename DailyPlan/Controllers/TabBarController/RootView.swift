//
//  ContentView.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 14.08.2024.
//

import SwiftUI


struct RootView: View {
    
    @State var selectedTab: Tabs = .tasks
    var body: some View {
        
        VStack (spacing: 0) {
            
            if selectedTab == .tasks {
                TaskViewController()
            } else if selectedTab == .files {
                FilesViewController()
            } else if selectedTab == .settings {
                SettingsViewController()
            }

            TabBarController(selectedTab: $selectedTab)
        }
    }
}


#Preview{
    RootView()
}
