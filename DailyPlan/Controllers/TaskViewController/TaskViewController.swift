//
//  TaskViewController.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 18.08.2024.
//

import SwiftUI

struct TaskViewController: View {
    
    @State private var tasks = Task.getTasks()
    
    var body: some View {
        Text("SOME")
    }
}

#Preview {
    TaskViewController()
}
