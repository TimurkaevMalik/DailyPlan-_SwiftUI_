//
//  DescriptionView.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 20.08.2024.
//

import SwiftUI

struct DescriptionView: View {
    
    @FocusState private var isFocused: Bool
    
    @Binding private var text: String
    @State private var lastText: String
    
    @State private var editorState: EditorState
    @State private var buttonsStateValues: ButtonStateValues
    
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
        
        editorState = .default
        lastText = ""
        buttonsStateValues = ButtonStateValues(state: .default)
    }
    
    var body: some View {
        
        RepresentedTextView(text: $text,
                            placeHolder: placeHolder,
                            linesNumber: focusedHeight == .medium ? 1 : 5)
        .tint(color)
        .focused($isFocused)
        .frame(height: editorState == .focused ? focusedHeight.rawValue : .mediumHeight)
        .multilineTextAlignment(.leading)
        .overlay {
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
                
                Color.clear
                
                HStack {
                    Spacer()
                    cancelButton
                    confirmationButton
                }
                .padding(.trailing, 12)
                .padding(.bottom, buttonsStateValues.padding)
            }
        }
        .background {
            RoundedRectangle(cornerRadius: .mediumCornerRadius)
                .stroke(color)
        }
        .onChange(of: isFocused, {
            lastText = text
            switchStateWithAnimation()
        })
    }
}

#Preview {
    @Previewable @State var text: String = ""
    DescriptionView(text: $text,
                    color: .messRed,
                    focusedHeight: .large,
                    placeHolder: "Description")
    .padding(.horizontal)
}

extension DescriptionView {
    enum FocusedHeight: CGFloat {
        case medium = 84
        case large = 184
    }
}

private extension DescriptionView {
    enum EditorState {
        case focused
        case `default`
    }
    
    struct ButtonStateValues {
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
    
    var cancelButton: some View {
        Button {
            text = lastText
            isFocused = false
        } label: {
            Image(systemName: "multiply")
                .frame(width: 50, height: buttonsStateValues.height)
                .foregroundStyle(.ypRed)
                .background(.messGradientFirst)
                .clipShape(.buttonBorder)
        }
    }
    
    var confirmationButton: some View {
        Button {
            isFocused = false
        } label: {
            Image(systemName: "checkmark")
                .frame(width: 50, height: buttonsStateValues.height)
                .foregroundStyle(.ypLightGreen)
                .background(.messGradientBottom)
                .clipShape(.buttonBorder)
        }
    }
}

private extension DescriptionView {
    func switchStateWithAnimation() {
        
        if isFocused {
            
            withAnimation(.bouncy(duration: 0.8, extraBounce: 0.2)) {
                editorState = .focused
                
            } completion: {
                withAnimation(.bouncy(duration: 0.8, extraBounce: 0.2)) {
                    buttonsStateValues = ButtonStateValues(state: editorState)
                }
            }
        } else {
            
            let editorDefaultState = EditorState.default
            
            withAnimation {
                
                buttonsStateValues = ButtonStateValues(state: editorDefaultState)
                
            } completion: {
                withAnimation {
                    editorState = editorDefaultState
                }
            }
        }
    }
}
