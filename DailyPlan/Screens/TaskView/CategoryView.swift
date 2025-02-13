//
//  CategoryView.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 02.02.2025.
//

import SwiftUI
///TODO: add crud
struct CategoryView: View {
    
    @Binding private var category: String
    @State private var color: Color
    @State private var categories: [String]
    @State private var isToggled: Bool
    
    init(category: Binding<String>, color: Color) {
        
        self.color = color
        _category = category
        isToggled = false
        categories = ["Education", "Work",
                      "Housework", "Unnecessary"]
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(categories, id: \.self) { category in
                        
                        categoryView(category,
                               isToggled: $isToggled)
                            .background(.ypMediumLightGray)
                            .setCornerRadius(14, basedOn: positionOf(category))
                    }
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .listSectionSeparator(.hidden)
                }
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
    func positionOf(_ category: String) -> ListItemPosition {
        
        if category == categories.first {
            return .first
        } else if category == categories.last {
            return .last
        } else {
            return ._default
        }
    }
}

private extension CategoryView {
    func categoryView(_ category: String,
                  isToggled: Binding<Bool>) -> some View {
        
        HStack {
            Text(category)
                .font(.category)
                .foregroundStyle(.ypBlack)
            
            Spacer(minLength: 0)
            
            Toggle("", isOn: $isToggled)
                .tint(color)
        }
        .frame(height: 66)
        .padding(.leading, 18)
        .padding(.trailing, 28)
    }
}
