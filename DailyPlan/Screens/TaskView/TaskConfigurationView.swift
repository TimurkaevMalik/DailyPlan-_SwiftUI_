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
    private let colors: [Color]
    
    init() {
        self.category = ""
        self.task = Task(description: "",
                         color: .clear,
                         schedule: .init(),
                         isDone: false)
        
        colors = [.ypLightPink, .ypCyan, .ypRed, .ypWarmYellow, .ypLightGreen]
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                CustomTextView(
                    text: $task.description,
                    color: .ypWarmYellow,
                    focusedHeight: .large,
                    placeHolder: "Description")
                
                CustomTextView(
                    text: $category,
                    color: .ypWarmYellow,
                    focusedHeight: .medium,
                    placeHolder: "Category")
                
                HStack {
                    
                    Text("Schedule")
                    
                    Spacer()
                    DatePicker(
                        "",
                        selection: .constant(.distantFuture),
                        displayedComponents: .hourAndMinute)
                    .frame(width: 80)
                    
                    DatePicker(
                        "",
                        selection: .constant(.distantFuture),
                        displayedComponents: .hourAndMinute)
                    .frame(width: 80)
                }
                .frame(height: 60)
                .font(Font.taskText)
                .padding(.horizontal, 8)
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.ypWarmYellow)
                })
                
                Spacer(minLength: 0)
                
                HStack {
                    ForEach(colors, id: \.self) { color in
                        
                        Button {
                            
                        } label: {
                            color
                                .frame(width: 48, height: 48)
                                .clipShape(.buttonBorder)
                        }
                    }
                }
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
