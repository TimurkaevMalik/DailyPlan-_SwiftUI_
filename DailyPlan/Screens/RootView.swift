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
        VStack(spacing: 0) {
            if selectedTab == .tasks {
                TasksListView()
            } else if selectedTab == .files {
                FoldersView()
            } else if selectedTab == .settings {
                SettingsView()
            }
            
            Spacer(minLength: 0)
            
            TabBarView(selectedTab: $selectedTab)
        }
        .onAppear {
            ///TODO: if TasksListView isEmpty but FoldersView is not - show FoldersView
        }
    }
}


#Preview{
    RootView()
}
