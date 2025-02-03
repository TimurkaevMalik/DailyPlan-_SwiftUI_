//
//  TaskConfigurationCell.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 01.02.2025.
//

import SwiftUI

struct TaskConfigurationView: View {
    
    @FocusState private var isFocused: Bool
    @Binding private var tasks: [TaskInfo]
    @State private var addTaskTapped: Bool
    @State private var task: TaskInfo
    @State private var category: String
    @State private var categoriesButtonState: Visibility
    private let colors: [Color]
    
    init(tasks: Binding<[TaskInfo]>) {
        self._tasks = tasks
        categoriesButtonState = .visible
        addTaskTapped = false
        category = ""
        colors = [.ypLightPink, .ypCyan,
                  .ypRed, .ypWarmYellow,
                  .ypGreen]
        task = TaskInfo(description: "",
                        color: .ypWarmYellow,
                        schedule: .init(),
                        isDone: false)
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                
                CustomTextView(
                    text: $task.description,
                    color: task.color,
                    focusedHeight: .large,
                    placeHolder: "Description")
                
                HStack(spacing: 0) {
                    CustomTextField(text: $category,
                                    isFocused: $isFocused,
                                    color: task.color)
                    
                    ///TODO: if categories != nil
                    if true == true {
                        ///TODO: change color to lightGreen if category exists or chosen
                        
                        storedCategoriesButton()
                            .padding(.leading, categoriesButtonState == .hidden ? 0 : 10)
                            .onTapGesture {
                                if categoriesButtonState == .visible {
                                    addTaskTapped.toggle()
                                }
                            }
                    }
                }
                
                scheduleView()
                
                Spacer(minLength: 0)
                
                HStack {
                    ForEach(colors, id: \.self) { color in
                        
                        Button {
                            task.color = color
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
        .sheet(isPresented: $addTaskTapped) {
            CategoryView(category: $category,
                         color: task.color)
            .presentationDetents([.medium])
        }
        .onChange(of: isFocused) {
            switchCategoriesButtonState()
        }
        .onDisappear {
            if !task.description.isEmpty {
                withAnimation {
                    tasks.insert(task, at: 0)
                }
            }
        }
    }
}

private extension TaskConfigurationView {
    func storedCategoriesButton() -> some View {
        RoundedRectangle(cornerRadius: 16)
            .stroke(task.color)
            .frame(width: categoriesButtonState == .hidden ? 0 : 56, height: 60)            .overlay(content: {
                Image(systemName: "list.bullet")
                    .resizable()
                    .frame(width: 34, height: 36)
                    .foregroundStyle(task.color)
            })
            .clipped()
    }
    
    ///TODO: move to file
    func scheduleView() -> some View {
        HStack {
            Text("Schedule")
            
            Spacer()
            DatePicker(
                "",
                selection: .constant(.distantFuture),
                displayedComponents: .date)
            .frame(width: 80)
            
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
                .stroke(task.color)
        })
    }
}

private extension TaskConfigurationView {
    func switchCategoriesButtonState() {
        if categoriesButtonState == .visible {
            
            withAnimation {
                categoriesButtonState = .hidden
            }
        } else {
            withAnimation {
                categoriesButtonState = .visible
            }
        }
    }
}

#Preview {
    TaskConfigurationView(tasks: .constant([]))
}
