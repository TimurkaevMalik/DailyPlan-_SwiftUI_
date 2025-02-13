//
//  ContentView.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 14.08.2024.
//

import SwiftUI


struct RootView: View {
    @State private var selectedTab: Tabs
    
    init() {
        selectedTab = .tasks
    }
    var body: some View {
        if selectedTab == .tasks {
            TaskView()
        } else if selectedTab == .files {
            FoldersView()
        } else if selectedTab == .settings {
            SettingsView()
        }
        
        Spacer(minLength: 0)
        
        TabBarView(selectedTab: $selectedTab)
    }
}


#Preview{
    RootView()
}
