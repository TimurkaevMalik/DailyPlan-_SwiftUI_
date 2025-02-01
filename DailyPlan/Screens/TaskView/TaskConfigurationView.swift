//
//  TaskConfigurationCell.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 01.02.2025.
//

import SwiftUI

struct TaskConfigurationView: View {
    
    @State private var task: Task
    @State private var category: String
    
    init() {
        self.category = ""
        self.task = Task(description: "",
                         color: .clear,
                         schedule: .init(),
                         isDone: false)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                CustomTextView(
                    text: $task.description,
                    color: .ypWarmYellow,
                    placeHolder: "Description")
                
                Spacer()
            }
            .padding(.horizontal, 8)
            .padding(.top, 8)
            .navigationTitle("Configure Task")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

private extension TaskConfigurationView {
    func categoryTextField() -> some View {
        TextField(text: $category) {
            Rectangle()
        }
    }
}

#Preview {
        TaskConfigurationView()
}
