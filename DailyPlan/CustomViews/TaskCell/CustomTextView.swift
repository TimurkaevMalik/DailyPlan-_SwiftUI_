//
//  CustomTextView.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 20.08.2024.
//

import SwiftUI

struct CustomTextView: View {
    
    @FocusState private var isFocused: Bool
    @State private var editorState: EditorState
    @State private var buttonsPadding: CGFloat
    @State private var lastText: String
    @Binding private var text: String
    
    private let color: Color
    private let placeHolder: String
    
    init(text: Binding<String>, color: Color, placeHolder: String) {
        self._text = text
        self.color = color
        self.placeHolder = placeHolder
        
        editorState = .default
        buttonsPadding = -30
        lastText = ""
    }
    
    var body: some View {
        
        Text(text)
        RepresentedTextView(text: $text,
                            placeHolder: placeHolder)
            .scrollContentBackground(.hidden)
        .focused($isFocused)
        .frame(height: editorState.rawValue)
        .padding(.horizontal, 6)
        .lineSpacing(2)
        .lineLimit(2)
        .font(Font.taskText)
        .multilineTextAlignment(.leading)
        .overlay {
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
                
                Color.clear
                
                HStack {
                    cancelButton()
                    confirmButton()
                }
                .padding(.trailing, 12)
                .padding(.bottom, buttonsPadding)
            }
            .clipped()
            .overlay(content: {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(color)
            })
        }
        .onChange(of: isFocused, {
            lastText = text
            switchStateWithAnimation()
        })
    }
}

private extension CustomTextView {
    func cancelButton() -> some View {
        Button {
            text = lastText
            isFocused = false
        } label: {
            Image(systemName: "multiply")
                .frame(width: 50, height: 30)
                .foregroundStyle(.ypRed)
                .background(.messGradientFirst)
                .clipShape(.buttonBorder)
        }
    }
    
    func confirmButton() -> some View {
        Button {
            isFocused = false
        } label: {
            Image(systemName: "checkmark")
                .frame(width: 50, height: 30)
                .foregroundStyle(.ypLightGreen)
                .background(.messGradientBottom)
                .clipShape(.buttonBorder)
        }
    }
}

private extension CustomTextView {
    enum EditorState: CGFloat {
        case focused = 184
        case `default` = 60
    }
    
    func switchStateWithAnimation() {
        if editorState == .default {
            
            withAnimation {
                editorState = .focused
            } completion: {
                withAnimation {
                    buttonsPadding = 6
                }
            }
        } else {
            withAnimation(.linear(duration: 0.2)) {
                buttonsPadding = -30
            } completion: {
                withAnimation {
                    editorState = .default
                }
            }
        }
    }
}

#Preview {
    CustomTextView(text: .constant(""),
                     color: .red,
                     placeHolder: "Description")
}
