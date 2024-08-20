//
//  CheckMarkButton.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 20.08.2024.
//

import SwiftUI

struct CheckMarkButton: View {
    
    let color: Color
    let isDone: Bool
    let size: CGSize
    let action: () -> Void
    
    var body: some View {
        
        Button {
            
            action()
            
        } label: {
            
            GeometryReader{geo in
                
                let width = geo.size.width
                let height = geo.size.height
                
                color.scaledToFill()
            
                Capsule()
                    .size(CGSize(width: width/2.5, height: height/2.5))
                    .stroke(lineWidth: 2)
                    .background(Color.clear)
                    .padding(.vertical, height/3.3)
                    .padding(.horizontal, width/3.3)
                    .tint(.black)
                
                if isDone == true {
                    
                    Image(systemName: "checkmark")
                        .tint(.white)
                        .font(Font.system(size: width/2.3, weight: .bold))
                        .position(CGPoint(x: height/2 + 2 , y: width/2 - 2 ))
                }
            }
        }
        .frame(width: size.width, height: size.height)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    CheckMarkButton(color: .blue,
                    isDone: true,
                    size: CGSize(width: 100, height: 100),
                    action: {})
}
