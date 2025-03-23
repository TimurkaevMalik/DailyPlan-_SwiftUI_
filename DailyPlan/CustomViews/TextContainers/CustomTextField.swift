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
    @State private var lastText: String = ""
    
    private let placeHolder: String
    private let color: Color
    
    init(text: Binding<String>,
         placeHolder: String,
         color: Color) {
        self._text = text
        self.placeHolder = placeHolder
        self.color = color
    }
    
    var body: some View {
        HStack(spacing: 0) {
            TextField(text: $text, label: {
                if !isFocused {
                    Text(placeHolder)
                        .foregroundStyle(.ypGray)
                        .font(.taskText)
                }
            })
            .frame(height: .mediumHeight)
            .tint(color)
            .font(.taskText)
            .padding(.leading, 10)
            .focused($isFocused)
            
            clearButton
                .padding(.trailing, 10)
        }
        .background {
            RoundedRectangle(cornerRadius: .regularCornerRadius)
                .stroke(color)
        }
        .onTapGesture {
            if !isFocused {
                isFocused = true
            }
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

#if DEBUG
#Preview {
    @Previewable@FocusState var isFocused: Bool
    @Previewable @State var text: String = ""
    
    CustomTextField(
        text: $text,
        placeHolder: "Placeholder",
        color: .ypWarmYellow)
}
#endif

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
