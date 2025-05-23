//
//  NonBindingToggle.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 03.03.2025.
//

import SwiftUI

struct NonBindingToggle: View {
    private let isOn: Bool
    private let color: Color
    private let tapAction: () -> Void
    @State private var state: ToggleState
    
    init(isOn: Bool,
         color: Color,
         tapAction: @escaping () -> Void) {
        self.isOn = isOn
        self.color = color
        self.tapAction = tapAction
        
        state = isOn ? .on : .off
    }
    
    var body: some View {
        
        Button {
            tapAction()
        } label: {
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 24, height: 24)
                .foregroundStyle(.ypWhite)
                .padding(.leading, state.rawValue)
        }
        .frame(width: 48, height: 28)
        .background(state == .on ?
                    color : .messGradientTop)
        .clipShape(.rect(cornerRadius: 8))
        .buttonStyle(StaticButtonStyle())
        .onChange(of: isOn) {
            changeState()
        }
    }
}

#if DEBUG
#Preview {
    @Previewable @State var isOn: Bool = false
    
    NonBindingToggle(isOn: isOn,
                     color: .ypWarmYellow,
                     tapAction: {
        isOn.toggle()
    })
}
#endif

private extension NonBindingToggle {
    func changeState() {
        if state == .off {
            withAnimation {
                self.state = .on
            }
            
        } else if state == .on {
            withAnimation {
                self.state = .off
            }
        }
    }
}

private extension NonBindingToggle {
    enum ToggleState: CGFloat {
        case on = 18
        case off = -18
    }
}
