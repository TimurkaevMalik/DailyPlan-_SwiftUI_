//
//  TaskConfigurationCell.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 01.02.2025.
//

import SwiftUI

struct TaskConfigurationView: View {
    
    @FocusState var isFocused: Bool
    @StateObject private var vm = TaskConfigurationViewModel()
    
    init() {}
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                
                DescriptionView(
                    text: $vm.task.description,
                    color: vm.task.color,
                    focusedHeight: .large,
                    placeHolder: "Description")
                
                HStack(spacing: 0) {
                    CustomTextField(
                        text: $vm.category,
                        placeHolder: "placeHolder",
                        color: vm.task.color)
                    .focused($isFocused)
                    
                    if !vm.categories.isEmpty {
                        storedCategoriesButton
                    }
                }
                
                ScheduleView(
                    color: vm.task.color,
                    schedule: $vm.task.schedule)
                
                Spacer(minLength: 0)
                
                HStack {
                    ForEach(vm.colors, id: \.self) { color in
                        
                        buttonOf(color: color)
                    }
                }
            }
            .padding(.horizontal, .screenHorizontalSpacing)
            .padding(.top, 8)
            .navigationTitle("Configure Task")
            .navigationBarTitleDisplayMode(.inline)
        }
        .sheet(isPresented: $vm.presentCategoriesView) {
            
            CategoriesView()
            .presentationDetents([.medium])
            .environmentObject(vm)
        }
        .onChange(of: isFocused) {
            switchCategoriesButtonState()
        }
        .onDisappear {
            if !vm.task.description.isEmpty {
                vm.storeNewTask()
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
            .foregroundStyle(doesCategoryExist() ? vm.task.color : .ypGray)
            .frame(width: vm.categoriesButtonState == .hidden ? 0 : width,
                   height: .mediumHeight)
            .clipped()
            .overlay(content: {
                RoundedRectangle(cornerRadius: .mediumCornerRadius)
                    .stroke(vm.task.color)
            })
            .padding(.leading, vm.categoriesButtonState == .hidden ? 0 : 10)
            .onTapGesture {
                if vm.categoriesButtonState == .visible {
                    vm.presentCategoriesView.toggle()
                }
            }
        
        return customView
    }
    
    private func buttonOf(color: Color) -> some View {
        Button {
            vm.task.color = color
        } label: {
            color
                .frame(width: 48, height: 48)
                .clipShape(.rect(cornerRadius: .mediumCornerRadius))
        }
    }
}

private extension TaskConfigurationView {
    func switchCategoriesButtonState() {
        if vm.categoriesButtonState == .visible {
            
            withAnimation {
                vm.categoriesButtonState = .hidden
            }
        } else {
            withAnimation {
                vm.categoriesButtonState = .visible
            }
        }
    }
    
    func doesCategoryExist() -> Bool {
        return vm.categories.contains {
            $0.lowercased() == vm.category.lowercased()
        }
    }
}

#Preview {
    TaskConfigurationView()
}
