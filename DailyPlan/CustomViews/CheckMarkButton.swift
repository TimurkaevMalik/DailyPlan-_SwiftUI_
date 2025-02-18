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
    
    private var markSize: CGSize
    
    init(color: Color, isDone: Binding<Bool>) {
        self.color = color
        self._isMarked = isDone
        markSize = CGSize(width: 26, height: 26)
    }
    
    var body: some View {
        
        Button {
            isMarked.toggle()
        } label: {
            ZStack(alignment: .center) {
                
                color
                Capsule()
                    .tint(.clear)
                    .frame(width: markSize.width,
                           height: markSize.height)
                    .overlay {
                        if isMarked {
                            RoundedRectangle(cornerRadius: markSize.width / 2)
                                .tint(.iconsSecondary)
                        } else {
                            RoundedRectangle(cornerRadius: markSize.width / 2)
                                .stroke(lineWidth: 4)
                                .tint(.iconsSecondary)
                        }
                    }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: .mediumCornerRadius))
    }
}


#Preview {
    @Previewable
    @State var isDone = true
    
    CheckMarkButton(color: .ypLightPink,
                    isDone: $isDone)
    .setSize(.checkMarkButton)
}
