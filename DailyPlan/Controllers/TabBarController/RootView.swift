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
        
        VStack {
            Text("Hello, world")
                .padding()
                .font(.callout)
        }
        
        Spacer()
        
        TabBarController(selectedTab: $selectedTab)
    }
}


#Preview{
    RootView()
}
