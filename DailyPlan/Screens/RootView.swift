//
//  ContentView.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 14.08.2024.
//

import SwiftUI


struct RootView: View {
    @State var text: String = ""
    var body: some View {
        TabBarView()
    }
}


#Preview{
    RootView()
}
