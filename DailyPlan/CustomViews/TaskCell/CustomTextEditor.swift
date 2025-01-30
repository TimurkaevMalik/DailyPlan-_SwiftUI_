//
//  CustomTextEditor.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 20.08.2024.
//

import SwiftUI

struct CustomTextEditor: View {
    
    @FocusState private var isFocused: Bool
    @State private var editorState: EditorState = .default
    @State private var buttonsPadding: CGFloat = -30
    @State var text: String
    
    let color: Color
    
    init(text: String, color: Color) {
        self.text = text
        self.color = color
    }
    
    var body: some View {
        
        TextEditor(text: $text)
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
                        
                        Spacer()
                        
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
                switchStateWithAnimation()
            })
            .onChange(of: text) {
                
                if text.count > 100 {
                    text = String(text.prefix(120))
                }
            }
    }
}

private extension CustomTextEditor {
    func cancelButton() -> some View {
        Button {
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

private extension CustomTextEditor {
    enum EditorState: CGFloat {
        case focused = 160
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
            withAnimation(.linear(duration: 0.1)) {
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
    CustomTextEditor(text: "Description Description Description Description Description Description Description Description",
                     color: .red)
}
