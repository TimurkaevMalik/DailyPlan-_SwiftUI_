//
//  CustomTextField.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 02.02.2025.
//

import SwiftUI

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
                .frame(height: 60)
                .padding(.horizontal, 10)
                .placeHolder(present: isFocused.wrappedValue || !text.isEmpty) {
                    Text("Category")
                        .foregroundStyle(.gray)
                        .font(.taskText)
                        .padding(.horizontal, 10)
                        .padding(.top, 8)
                }
            
            if isFocused.wrappedValue {
                Button {
                    text = ""
                    isFocused.wrappedValue.toggle()
                } label: {
                    Image(systemName: "x.square")
                        .font(.system(size: 20, weight: .medium))
                        .frame(width: 60, height: 60)
                        .foregroundStyle(.messGrayText)
                }
            }
        }
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

#Preview {
    @FocusState var isFocused: Bool
    return CustomTextField(text: .constant(""),
                    isFocused: $isFocused,
                    color: .ypWarmYellow)
}
