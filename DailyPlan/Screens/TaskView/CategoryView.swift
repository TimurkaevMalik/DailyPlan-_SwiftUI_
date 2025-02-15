//
//  CategoryView.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 02.02.2025.
//

import SwiftUI
///TODO: add methods: deleting and creating category
///TODO: solve bug - doesn't set written category in the rootView when you navigate
struct CategoryView: View {
    
    @Binding private var category: String
    @State private var color: Color
    @State private var categories: [CategoryItem]
    
    init(category: Binding<String>,
         color: Color) {
        
        self.color = color
        _category = category
        categories = [.init(title: "Education"),
                      .init(title: "Work"),
                      .init(title: "Housework"),
                      .init(title: "Unnecessary")]
    }
    
    var body: some View {
        NavigationStack {
            
            List($categories.indices, id: \.self) { index in
                categoryItemView(
                    categories[index],
                    isToggled: $categories[index].isDone)
                
                .background(.ypMediumLightGray)
                .setCornerRadius(14, basedOn: positionOf(categories[index]))
                .listSectionSeparator(.hidden)
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                .padding(.top, index == 0 ? 14 : 0)
            }
            .padding(.horizontal, 14)
            .listStyle(.inset)
            .scrollContentBackground(.hidden)
            .navigationTitle("Choose Category")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    CategoryView(category: .constant(""),
                 color: .ypLightPink)
}

private extension CategoryView {
    struct CategoryItem: Equatable {
        let id = UUID()
        let title: String
        var isDone: Bool
        
        init(title: String, isDone: Bool = false) {
            self.title = title
            self.isDone = isDone
        }
        
        mutating func setDoneTo(_ bool: Bool) {
            isDone = bool
        }
    }
}

private extension CategoryView {
    func positionOf(_ category: CategoryItem) -> ListItemPosition {
        
        if category == categories.first {
            return .first
        } else if category == categories.last {
            return .last
        } else {
            return ._default
        }
    }
    
    func toggleWasTapped() {
        categories.indices.forEach({
            categories[$0].setDoneTo(
                category == categories[$0].title)
        })
    }
}

private extension CategoryView {
    func categoryItemView(_ category: CategoryItem,
                          isToggled: Binding<Bool>) -> some View {
        Toggle(isOn: isToggled){
            Text(category.title)
                .font(.category)
                .foregroundStyle(.ypBlack)
        }
        .tint(color)
        .frame(height: 66)
        .padding(.leading, 18)
        .padding(.trailing, 28)
        .onChange(of: isToggled.wrappedValue) {
            if self.category == category.title {
                self.category = ""
            } else if isToggled.wrappedValue {
                self.category = category.title
            }
            toggleWasTapped()
        }
    }
}
