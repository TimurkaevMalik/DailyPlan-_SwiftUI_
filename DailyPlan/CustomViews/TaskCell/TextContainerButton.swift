//
//  TextContainerButton.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 20.08.2024.
//

import SwiftUI

struct TextContainerButton: View {
    
    let text: String
    let color: Color
    let height: CGFloat
    let action: () -> Void
    
    var body: some View {
        
        Button {
            action()
        } label: {
            
            GeometryReader { geo in
                
                Rectangle()
                    .tint(.white)
                    .clipShape(.rect(cornerRadius: geo.size.height/10))
                    .overlay(
                        RoundedRectangle(cornerRadius:  geo.size.height/10)
                            .strokeBorder(color, lineWidth: 1))
                
                Text(text)
                    .tint(.black)
                    .font(.system(size: 19, weight: .regular))
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .padding([.leading, .trailing, .top, .bottom], 4)
                
            }
            .frame(height: height)
            
        }
        .frame(height: 55)
    }
    
}

#Preview {
    TextContainerButton(text: "SOME", color: .blue, height: 55, action: {})
}
