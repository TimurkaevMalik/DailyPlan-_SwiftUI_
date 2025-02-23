//
//  CategoriesView.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 02.02.2025.
//

import SwiftUI

struct CategoriesView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = CategoriesViewModel()
    
    init() {}
    
    var body: some View {
        NavigationStack {
            List {
                ForEach($vm.categories.indices, id: \.self) { index in
                    
                    categoryItemView(
                        vm.categories[index],
                        isToggled: $vm.categories[index].isChosen)
                    .setCornerRadius(.mediumCornerRadius, basedOn: positionOf(vm.categories[index]))
                }
                .onDelete(perform: vm.deleteItem)
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
        .onAppear {
            vm.setLastChosenCategory()
        }
    }
}

#Preview {
    CategoriesView()
}

private extension CategoriesView {
    func categoryItemView(_ category: CategoryItem, isToggled: Binding<Bool>) -> some View {
        
        LabeledContent(category.title) {
            Toggle("", isOn: isToggled)
                .tint(vm.color)
        }
        .foregroundStyle(.ypBlack)
        .font(.category)
        .frame(height: 66)
        .padding(.leading, 18)
        .padding(.trailing, 28)
        .background(.ypMediumLightGray)
        .overlay(alignment:.init(horizontal: .center, vertical: .top)) {
            if vm.category != vm.categories.first?.title {
                Divider()
                    .padding(.leading, 16)
            }
        }
        .onChange(of: isToggled.wrappedValue) {
            if vm.category == category.title,
               !isToggled.wrappedValue {
                vm.category = ""
            } else if isToggled.wrappedValue {
                vm.category = category.title
            }
            vm.setLastChosenCategory()
        }
    }
}

private extension CategoriesView {
    func positionOf(_ category: CategoryItem) -> ListItemPosition {
        
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
