//
//  CustomTextView.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 20.08.2024.
//

import SwiftUI

struct CustomTextView: View {
    
    @FocusState private var isFocused: Bool
    
    @Binding private var text: String
    @State private var lastText: String
    
    @State private var state: EditorState
    @State private var stateValues: StateValues
    
    private let focusedHeight: FocusedHeight
    private let color: Color
    private let placeHolder: String
    
    init(text: Binding<String>,
         color: Color,
         focusedHeight: FocusedHeight,
         placeHolder: String) {
        self._text = text
        self.color = color
        self.placeHolder = placeHolder
        self.focusedHeight = focusedHeight
        
        state = .default
        lastText = ""
        stateValues = StateValues(state: .default)
    }
    
    var body: some View {
        
        RepresentedTextView(text: $text,
                            placeHolder: placeHolder,
                            linesNumber: focusedHeight == .medium ? 1 : 5)
        .tint(color)
        .focused($isFocused)
        .frame(height: state == .focused ? focusedHeight.rawValue : .mediumHeight)
        .padding(.horizontal, 10)
        .multilineTextAlignment(.leading)
        .overlay {
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
                
                Color.clear
                
                HStack {
                    cancelButton()
                    confirmButton()
                }
                .padding(.trailing, 12)
                .padding(.bottom, stateValues.padding)
            }
            .clipped()
            .overlay(content: {
                RoundedRectangle(cornerRadius: .mediumCornerRadius)
                    .stroke(color)
            })
        }
        .onChange(of: isFocused, {
            lastText = text
            switchStateWithAnimation()
        })
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
    
    struct StateValues {
        let padding: CGFloat
        let height: CGFloat
        
        init(state: EditorState) {
            switch state {
            case .focused:
                padding = 6
                height = 30
            case .default:
                padding = 0
                height = 0
            }
        }
    }
    
    func cancelButton() -> some View {
        Button {
            text = lastText
            isFocused = false
        } label: {
            Image(systemName: "multiply")
                .frame(width: 50, height: stateValues.height)
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
                .frame(width: 50, height: stateValues.height)
                .foregroundStyle(.ypLightGreen)
                .background(.messGradientBottom)
                .clipShape(.buttonBorder)
        }
    }
}

private extension CustomTextView {
    func switchStateWithAnimation() {
        if state == .default {
            
            withAnimation {
                state = .focused
            } completion: {
                withAnimation {
                    stateValues = StateValues(state: state)
                }
            }
        } else {
            
            let defaultState = EditorState.default
            
            withAnimation(.linear(duration: 0.2)) {
                
                stateValues = StateValues(state: defaultState)
                
            } completion: {
                withAnimation {
                    state = defaultState
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var text: String = ""
    CustomTextView(text: $text,
                   color: .ypWarmYellow,
                   focusedHeight: .large,
                   placeHolder: "Description")
}
