//
//  DescriptionView.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 20.08.2024.
//

import SwiftUI

///TODO: make modifier that sets specific corners with stroke (just move code of "buttonOf(schedule: String)" to modifier's struct
struct DescriptionView: View {
    
    @FocusState private var isFocused: Bool
    
    @Binding private var text: String
    @State private var lastText: String
    
    @State private var editorState: EditorState
    @State private var buttonsStateValues: ButtonStateValues
    
    private let focusedHeight: FocusedHeight
    private let color: Color
    private let placeHolder: String
    private let schedule: Schedule?
    
    init(text: Binding<String>,
         color: Color,
         focusedHeight: FocusedHeight,
         placeHolder: String,
         schedule: Schedule? = nil) {
        self._text = text
        self.color = color
        self.placeHolder = placeHolder
        self.focusedHeight = focusedHeight
        self.schedule = schedule
        
        editorState = .default
        lastText = ""
        buttonsStateValues = ButtonStateValues(state: .default)
    }
    
    var body: some View {
        
        VStack(alignment: .trailing, spacing: 0) {
            
            if let scheduleString = stringFromSchedule() {
                buttonOf(schedule: scheduleString)
            }
            
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
                        cancelButton()
                        confirmButton()
                    }
                    .padding(.trailing, 12)
                    .padding(.bottom, buttonsStateValues.padding)
                }
            }
            .clipShape(.rect(
                topLeadingRadius: .mediumCornerRadius,
                bottomLeadingRadius: .mediumCornerRadius,
                bottomTrailingRadius: .mediumCornerRadius,
                topTrailingRadius:
                    shouldRoundCorner()))
            .background {
                Rectangle()
                    .foregroundStyle(color)
                    .clipShape(.rect(topLeadingRadius: .mediumCornerRadius, bottomLeadingRadius: .mediumCornerRadius, bottomTrailingRadius: .mediumCornerRadius, topTrailingRadius: shouldRoundCorner()))
                    .padding(.all, -1)
            }
            .onChange(of: isFocused, {
                lastText = text
                switchStateWithAnimation()
            })
        }
    }
}

#Preview {
    @Previewable @State var text: String = ""
    DescriptionView(text: $text,
                   color: .messRed,
                   focusedHeight: .large,
                   placeHolder: "Description",
                   schedule: Schedule(start: .now))
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
    
    func buttonOf(schedule: String) -> some View {
        Button {
            ///TODO: show editing menu
        } label: {
            Text(schedule)
                .padding(.horizontal, 12)
                .tint(.ypBlack)
                .background {
                    Rectangle()
                        .foregroundStyle(.white)
                        .clipShape(.rect(topLeadingRadius: .regularCornerRadius, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: .regularCornerRadius))
                }
                .background {
                    Rectangle()
                        .foregroundStyle(color)
                        .clipShape(.rect(topLeadingRadius: .regularCornerRadius, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: .regularCornerRadius))
                        .padding(.all, -1)
                }
        }
    }
    
    func cancelButton() -> some View {
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
    
    func confirmButton() -> some View {
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
        if editorState == .default {
            
            withAnimation(.snappy(duration: 0.6, extraBounce: 0.4)) {
                editorState = .focused
                
            } completion: {
                withAnimation(.snappy(duration: 0.4, extraBounce: 0.4)) {
                    buttonsStateValues = ButtonStateValues(state: editorState)
                }
            }
        } else {
            
            let editorDefaultState = EditorState.default
            
            withAnimation(.smooth) {
                
                buttonsStateValues = ButtonStateValues(state: editorDefaultState)
                
            } completion: {
                withAnimation(.smooth) {
                    editorState = editorDefaultState
                }
            }
        }
    }
    
    func shouldRoundCorner() -> CGFloat {
        
        if (stringFromSchedule() == nil) {
            return .mediumCornerRadius
        } else {
            return 0
        }
    }
    
    func stringFromSchedule() -> String? {
        guard let schedule else { return nil }
        
        if let start = schedule.start,
           let end = schedule.end {
            
            let startString = timeString(from: start)
            let endString = timeString(from: end)
            
            return "\(startString) - \(endString)"
            
        } else if let start = schedule.start {
            return timeString(from: start)
        } else if let end = schedule.end {
            return timeString(from: end)
        } else {
            return nil
        }
    }
    
    func timeString(from date: Date) -> String {
        DateFormatManager.shared.timeString(from: date)
    }
}
