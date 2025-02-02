//
//  CategoryView.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 02.02.2025.
//

import SwiftUI

struct CategoryView: View {
    
    @Binding private var category: String
    @State private var color: Color
    @State private var categories: [String]
    
    init(category: Binding<String>, color: Color) {
        self._category = category
        self.color = color
        categories = ["Education", "Work",
                      "Housework", "Unnecessary"]
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(categories, id: \.self) { category in
                        
                        button(category: category) {
                            
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 20)
            }
            Spacer(minLength: 0)
                .padding(.horizontal, 8)
                .padding(.top, 8)
                .navigationTitle("Choose Category")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

private extension CategoryView {
    func button(category: String, action: () -> Void) -> some View {
        
        Button {
            self.category = category
        } label: {
            HStack {
                if category == self.category.trimmingCharacters(in: .whitespacesAndNewlines) {
                    Circle()
                        .frame(height: 20)
                } else {
                    Circle()
                        .stroke()
                        .frame(height: 20)
                }
                
                Text(category)
                    .font(.title)
                
            }
            .foregroundStyle(.ypBlack)
        }
    }
}

#Preview {
    CategoryView(category: .constant(""),
                 color: .ypWarmYellow)
}
