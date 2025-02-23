//
//  CustomTextField.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 02.02.2025.
//

import SwiftUI
///TODO: add method - (isFocused = false on screen tap)
struct CustomTextField: View {
    
    @FocusState private var isFocused: Bool
    @Binding private var text: String
    @State private var lastText: String
    
    private let placeHolder: String
    private let color: Color
    
    init(text: Binding<String>,
         placeHolder: String,
         color: Color) {
        self._text = text
        self.placeHolder = placeHolder
        self.color = color
        lastText = ""
    }
    
    var body: some View {
        HStack(spacing: 0) {
            TextField(text: $text, label: {
                if !isFocused {
                    Text("Category")
                        .foregroundStyle(.ypGray)
                        .font(.taskText)
                }
            })
            .focused($isFocused)
            .tint(color)
            .font(.taskText)
            .frame(height: .mediumHeight)
            .padding(.leading, 10)
            
            clearButton
                .padding(.trailing, 10)
        }
        .clipped()
        .overlay {
            RoundedRectangle(cornerRadius: .mediumCornerRadius)
                .stroke(color)
        }
        .onChange(of: isFocused, { oldValue, newValue in
            text = text.trimmingCharacters(in: .whitespaces)
        })
        .onChange(of: text) {
            if text.count > 25 {
                text = lastText
            } else {
                lastText = text
            }
        }
    }
}

private extension CustomTextField {
    var clearButton: some View {
        Button {
            if isFocused {
                text = ""
                isFocused = false
            } else {
                isFocused = true
            }
        } label: {
            Image(systemName: "x.square")
                .foregroundStyle(isFocused ? .messGrayText : .clear)
                .font(.system(size: 20, weight: .medium))
                .frame(width: 40, height: 40)
        }
    }
}

#Preview {
    @Previewable@FocusState var isFocused: Bool
    @Previewable @State var text: String = ""
    
    CustomTextField(
        text: $text,
        placeHolder: "Placeholder",
        color: .ypWarmYellow)
}
