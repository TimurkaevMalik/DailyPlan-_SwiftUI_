//
//  CheckMarkButton.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 20.08.2024.
//

import SwiftUI

struct CheckMarkButton: View {
    
    @State var color: Color
    @Binding var isDone: Bool
    
    private var size: CGSize
    
    init(color: Color, isDone: Binding<Bool>) {
        self.color = color
        self._isDone = isDone
        size = CGSize(width: 26, height: 26)
    }
    
    var body: some View {
        
        Button {
            isDone.toggle()
        } label: {
            ZStack(alignment: .center) {
                
                color
                Capsule()
                    .tint(.clear)
                    .frame(width: size.width,
                           height: size.height)
                    .overlay {
                        if isDone {
                            RoundedRectangle(cornerRadius: size.width / 2)
                                .tint(.iconsSecondary)
                        } else {
                            RoundedRectangle(cornerRadius: size.width / 2)
                                .stroke(lineWidth: 4)
                                .tint(.iconsSecondary)
                        }
                    }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .frame(width: 60, height: 60)
    }
}


#Preview {
    @Previewable @State var isDone = true

    CheckMarkButton(color: .ypLightPink,
                    isDone: $isDone)
}
