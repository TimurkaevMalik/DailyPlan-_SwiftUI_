//
//  CustomTextField.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 02.02.2025.
//

import SwiftUI
///TODO: set regular text Font
///TODO: add method - (isFocused = false on screen tap)
struct CustomTextField: View {
    
    @Binding private var text: String
    @State private var lastText: String
    private let color: Color
    private var isFocused: FocusState<Bool>.Binding
    
    init(text: Binding<String>,
         isFocused: FocusState<Bool>.Binding,
         color: Color) {
        self._text = text
        self.color = color
        self.isFocused = isFocused
        lastText = ""
    }
    
    var body: some View {
        HStack(spacing: 0) {
            TextField("", text: $text)
                .focused(isFocused)
                .tint(color)
                .font(.taskText)
                .frame(height: 60)
                .padding(.leading, 10)
                .placeHolder(present: isFocused.wrappedValue || !text.isEmpty) {
                    Text("Category")
                        .foregroundStyle(.grayPlaceholder)
                        .font(.taskText)
                        .padding(.horizontal, 10)
                }
            
            clearButton()
                .padding(.trailing, 10)
        }
        .clipped()
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(color)
        }
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
    func clearButton() -> some View {
        Button {
            if isFocused.wrappedValue {
                text = ""
                isFocused.wrappedValue.toggle()
            } else {
                isFocused.wrappedValue = true
            }
        } label: {
            Image(systemName: "x.square")
                .foregroundStyle(isFocused.wrappedValue ? .messGrayText : .clear)
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
        isFocused: $isFocused,
        color: .ypWarmYellow)
}
