//
//  CategoriesView.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 02.02.2025.
//

import SwiftUI

struct CategoriesView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm: TaskConfigurationViewModel
    
    init() {}
    
    var body: some View {
        NavigationStack {
            List {
                ForEach($vm.categories.indices, id: \.self) { index in
                    
                    categoryItemView(
                        vm.categories[index])
                    .setCornerRadius(.mediumCornerRadius, basedOn: positionOf(vm.categories[index]))
                    .overlay(alignment:.init(horizontal: .center, vertical: .top)) {
                        if index != 0 {
                            Divider()
                                .padding(.leading, 16)
                        }
                    }
                }
                .onDelete(perform: { indexSet in
                    withAnimation {
                        vm.deleteCategory(at: indexSet)
                    }
                })
                .listRowSeparator(.hidden)
                .listSectionSeparator(.hidden)
                .listRowInsets(
                    .init(top: 0,
                          leading: 0,
                          bottom: 0,
                          trailing: 0))
            }
            .padding(.horizontal, .screenHorizontalSpacing)
            .listStyle(.plain)
            .navigationTitle("Choose Category")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onChange(of: vm.categories, {
            if vm.categories.isEmpty {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    dismiss()
                }
            }
        })
    }
}

#Preview {
    CategoriesView()
        .environmentObject(
            TaskConfigurationViewModel())
}

private extension CategoriesView {
    func categoryItemView(_ category: String) -> some View {
        
        HStack {
            Text(category)
            
            Spacer()
            
            NonBindingToggle(
                isOn: category == vm.category,
                color: vm.task.color) {
                    if vm.category == category {
                        vm.category = ""
                    } else {
                        vm.category = category
                    }
                }
        }
        .foregroundStyle(.ypBlack)
        .font(.category)
        .frame(height: 66)
        .padding(.leading, 18)
        .padding(.trailing, 28)
        .background(.ypMediumLightGray)
    }
}



private extension CategoriesView {
    func positionOf(_ category: String) -> ListItemPosition {
        
        if vm.categories.count == 1 {
            return .single
        } else if category == vm.categories.first {
            return .first
        } else if category == vm.categories.last {
            return .last
        } else {
            return ._default
        }
    }
}
