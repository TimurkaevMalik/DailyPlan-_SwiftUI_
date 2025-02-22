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
    
    private var categories: [String]
    private let colors: [Color]
    
    init(tasks: Binding<[TaskInfo]>) {
        self._tasks = tasks
        categoriesButtonState = .visible
        addTaskTapped = false
        category = ""
        
        colors = [.ypLightPink, .ypCyan,
                  .ypRed, .ypWarmYellow,
                  .ypGreen]
        
        categories = ["Education", "Work",
                      "Housework", "Unnecessary"]
        
        task = TaskInfo(description: "",
                        color: .ypWarmYellow,
                        schedule: .init(),
                        isDone: false)
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                
                DescriptionView(
                    text: $task.description,
                    color: task.color,
                    focusedHeight: .large,
                    placeHolder: "Description")
                
                HStack(spacing: 0) {
                    CustomTextField(text: $category,
                                    isFocused: $isFocused,
                                    color: task.color)
                    
                    if !categories.isEmpty {
                        storedCategoriesButton
                    }
                }
                
                ScheduleView(
                    color: task.color,
                    schedule: $task.schedule)
                
                Spacer(minLength: 0)
                
                HStack {
                    ForEach(colors, id: \.self) { color in
                        
                        buttonOf(color: color)
                    }
                }
            }
            .padding(.horizontal, .screenHorizontalSpacing)
            .padding(.top, 8)
            .navigationTitle("Configure Task")
            .navigationBarTitleDisplayMode(.inline)
        }
        .sheet(isPresented: $addTaskTapped) {
            CategoriesView(category: $category,
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
    var storedCategoriesButton: some View {
        
        let width = CGSize.checkMarkButton.width
        
        let customView = Image(systemName: "list.bullet")
            .resizable()
            .frame(width: 34, height: 36)
            .foregroundStyle(doesCategoryExist() ? task.color : .grayPlaceholder)
            .frame(width: categoriesButtonState == .hidden ? 0 : width,
                   height: .mediumHeight)
            .clipped()
            .overlay(content: {
                RoundedRectangle(cornerRadius: .mediumCornerRadius)
                    .stroke(task.color)
            })
            .padding(.leading, categoriesButtonState == .hidden ? 0 : 10)
            .onTapGesture {
                if categoriesButtonState == .visible {
                    addTaskTapped.toggle()
                }
            }
        
        return customView
    }
    
    private func buttonOf(color: Color) -> some View {
        Button {
            task.color = color
        } label: {
            color
                .frame(width: 48, height: 48)
                .clipShape(.rect(cornerRadius: .mediumCornerRadius))
        }
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
    
    func doesCategoryExist() -> Bool {
        return categories.contains {
            $0.lowercased() == category.lowercased()
        }
    }
}

#Preview {
    TaskConfigurationView(tasks: .constant([]))
}
