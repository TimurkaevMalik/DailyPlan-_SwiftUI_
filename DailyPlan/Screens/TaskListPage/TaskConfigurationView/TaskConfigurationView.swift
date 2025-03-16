//
//  TaskConfigurationCell.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 01.02.2025.
//

import SwiftUI
import RealmSwift
struct TaskConfigurationView: View {
    
    @FocusState var isFocused: Bool
    @StateObject private var vm = TaskConfigurationViewModel()
    
    init() {}
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                
                DescriptionView(
                    text: $vm.taskText,
                    color: vm.color,
                    focusedHeight: .large,
                    placeHolder: "Description")
                
                CustomTextField(
                    text: $vm.category,
                    placeHolder: "placeHolder",
                    color: vm.color)
                .focused($isFocused)
                .modifier(categoriesButtonModifier)
                
                ScheduleView(
                    color: vm.color,
                    schedule: $vm.schedule)
                
                Spacer(minLength: 0)
                
                HStack {
                    ForEach(vm.availableColors,
                            id: \.self) { color in
                        
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
            
            CategoriesView(viewModel: vm)
                .presentationDetents([.medium])
        }
        .onChange(of: isFocused) {
            switchCategoriesButtonState()
        }
        .onDisappear {
            if !vm.taskText.isEmpty {
                vm.storeNewTask()
            }
        }
    }
}

#if DEBUG
#Preview {
    TaskConfigurationView()
}
#endif

private extension TaskConfigurationView {
    var categoriesButtonModifier: some ViewModifier {
        
        let statePredicate: Visibility = vm.categories.isEmpty ? .hidden : vm.categoriesButtonState
        
        let image: Image = Image(systemName:
                                    "list.bullet")
        
        return ToggleVisibilityButton(
            state: statePredicate,
            image: image,
            color: vm.color,
            action: {
                vm.presentCategoriesView.toggle()
            })
    }
    
    private func buttonOf(color: Color) -> some View {
        Button {
            vm.color = color
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
