//
//  CheckMarkButton.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 20.08.2024.
//

import SwiftUI

struct CheckMarkButton: View {
    
    @State var color: Color
    @Binding var isMarked: Bool
    
    init(color: Color, isDone: Binding<Bool>) {
        self.color = color
        self._isMarked = isDone
    }
    
    var body: some View {
        
        Button {
            isMarked.toggle()
        } label: {
            ZStack(alignment: .center) {
                
                color
                Capsule()
                    .tint(.clear)
                    .frame(width: 24,
                           height: 24)
                    .overlay {
                        if isMarked {
                            RoundedRectangle(cornerRadius: 8)
                                .tint(.iconsSecondary)
                        } else {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(lineWidth: 4)
                                .tint(.iconsSecondary)
                        }
                    }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: .regularCornerRadius))
    }
}

#if DEBUG
#Preview {
    @Previewable
    @State var isDone = true
    
    CheckMarkButton(color: .ypLightPink,
                    isDone: $isDone)
    .setSize(.checkMarkButton)
}
#endif
