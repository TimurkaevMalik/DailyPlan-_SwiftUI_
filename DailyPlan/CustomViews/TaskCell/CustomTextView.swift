//
//  CustomTextView.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 20.08.2024.
//

import SwiftUI

struct CustomTextView: View {
    
    @FocusState private var isFocused: Bool
    @State private var state: EditorState
    @State private var buttonsPadding: CGFloat
    @State private var lastText: String
    @Binding private var text: String
    
    private let color: Color
    private let placeHolder: String
    private let focusedHeight: FocusedHeight
    
    init(text: Binding<String>,
         color: Color,
         focusedHeight: FocusedHeight,
         placeHolder: String) {
        self._text = text
        self.color = color
        self.placeHolder = placeHolder
        self.focusedHeight = focusedHeight
        
        state = .default
        buttonsPadding = -30
        lastText = ""
    }
    
    var body: some View {
        
        RepresentedTextView(text: $text,
                            placeHolder: placeHolder,
                            linesNumber: focusedHeight == .medium ? 1 : 5)
        .focused($isFocused)
        .frame(height: state == .focused ? focusedHeight.rawValue : 60)
        .padding(.horizontal, 6)
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

extension CustomTextView {
    enum FocusedHeight: CGFloat {
        case medium = 84
        case large = 184
    }
}

private extension CustomTextView {
    enum EditorState {
        case focused
        case `default`
    }
    
    func switchStateWithAnimation() {
        
        if state == .default {
            
            withAnimation {
                state = .focused
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
                    state = .default
                }
            }
        }
    }
}

#Preview {
    CustomTextView(text: .constant(""),
                   color: .red,
                   focusedHeight: .large,
                   placeHolder: "Description")
}
