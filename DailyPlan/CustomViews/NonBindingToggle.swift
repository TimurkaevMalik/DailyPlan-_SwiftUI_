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
    
    init(isOn: Bool,
         color: Color,
         tapAction: @escaping () -> Void) {
        self.isOn = isOn
        self.color = color
        self.tapAction = tapAction
    }
    
    var body: some View {
        Button {
            tapAction()
        } label: {
            ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
                    Circle()
                        .foregroundStyle(.ypWhite)
                        .padding(.all, 2)
                        .padding(.leading, isOn ? 20 : -20)
                }
                .frame(width: 52, height: 32)
                .background(isOn ? color : .messGradientTop)
                .clipShape(.rect(cornerRadius: 16))
        }
        .buttonStyle(.staticButton())
//        .onChange(of: isOn) {
//            animatedPadding()
//        }
    }
}

//private extension NonBindingToggle {
//    enum ToggleState {
//        case on
//        case off
//    }
//    
//    struct ToggleParameters {
//        let width: CGFloat
//        let padding: CGFloat
//    }
//}
//
//private extension NonBindingToggle {
//    func animatedPadding() -> CGFloat {
//        
//    }
//}

#Preview {
    @Previewable @State var isOn: Bool = false
    
    NonBindingToggle(isOn: isOn,
                     color: .ypWarmYellow,
                     tapAction: { isOn.toggle() })
}
