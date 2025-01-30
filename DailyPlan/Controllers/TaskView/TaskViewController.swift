//
//  TaskViewController.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 18.08.2024.
//

import SwiftUI

struct TaskViewController: View {
    
    @State private var tasks: [Task] = {
        let array = Task.getTasksMock().sorted(by: { $0.schedule ?? ""  < $1.schedule ?? "" })
        return array
    }()
    
    var body: some View {
        ScrollView {
            ForEach(tasks) { task in
                TaskCell(task: task)
                    .padding(.vertical, 6)
            }
            .padding(.horizontal, 6)
        }
    }
}

#Preview {
    TaskViewController()
}
