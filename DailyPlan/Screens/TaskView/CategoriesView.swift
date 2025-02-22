//
//  CategoriesView.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 02.02.2025.
//

import SwiftUI

struct CategoriesView: View {
    
    @Environment(\.dismiss) var dismiss
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
            List {
                ForEach($categories.indices, id: \.self) { index in
                    
                    categoryItemView(
                        categories[index],
                        isToggled: $categories[index].isChosen)
                    .setCornerRadius(.mediumCornerRadius, basedOn: positionOf(categories[index]))
                }
                .onDelete(perform: deleteItem)
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
        .onAppear {
            setLastChosenCategory()
        }
    }
}

#Preview {
    @Previewable @State var category: String = ""
    CategoriesView(category: $category,
                   color: .ypLightPink)
}

private extension CategoriesView {
    struct CategoryItem: Equatable {
        let id = UUID()
        let title: String
        var isChosen: Bool
        
        init(title: String, isChosen: Bool = false) {
            self.title = title
            self.isChosen = isChosen
        }
        
        mutating func shouldSetChosen(_ bool: Bool) {
            isChosen = bool
        }
    }
}

private extension CategoriesView {
    func categoryItemView(
        _ category: CategoryItem,
        isToggled: Binding<Bool>) -> some View {
        
            LabeledContent(category.title) {
                Toggle("", isOn: isToggled)
                    .tint(color)
            }
            .foregroundStyle(.ypBlack)
            .font(.category)
            .frame(height: 66)
            .padding(.leading, 18)
            .padding(.trailing, 28)
            .background(.ypMediumLightGray)
            .overlay(alignment:.init(horizontal: .center, vertical: .top)) {
                if category != categories.first {
                    Divider()
                        .padding(.leading, 16)
                }
            }
            .onChange(of: isToggled.wrappedValue) {
                if self.category == category.title,
                   !isToggled.wrappedValue {
                    self.category = ""
                } else if isToggled.wrappedValue {
                    self.category = category.title
                }
                setLastChosenCategory()
            }
    }
}

private extension CategoriesView {
    func deleteItem(at offSet: IndexSet) {
        withAnimation {
            categories.remove(atOffsets: offSet)
        } completion: {
            if categories.isEmpty {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    dismiss()
                }
            }
        }
    }
    
    func positionOf(_ category: CategoryItem) -> ListItemPosition {
        
        if categories.count == 1 {
            return .single
        } else if category == categories.first {
            return .first
        } else if category == categories.last {
            return .last
        } else {
            return ._default
        }
    }
    
    func setLastChosenCategory() {
        categories.indices.forEach({
            categories[$0].shouldSetChosen(
                category.lowercased() == categories[$0].title.lowercased())
        })
    }
}
