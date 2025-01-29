//
//  TaskViewController.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 18.08.2024.
//

import SwiftUI

struct TaskViewController: View {
    
    @State private var tasks = Task.getTasksMock()
    
    var body: some View {
        Color.cyan
    }
}

#Preview {
    TaskViewController()
}
