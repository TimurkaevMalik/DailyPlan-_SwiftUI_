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
    let action: () -> Void
    
    var body: some View {
        
        Button {
            
            action()
            
        } label: {
            ZStack(alignment: .center) {
                color
                
                Capsule()
                    .stroke(lineWidth: 2)
                    .background(Color.clear)
                    .tint(.black)
                    .frame(width: 26, height: 26)
                
                if isDone == true {
                    
                    Image(systemName: "checkmark")
                        .resizable()
                        .frame(width: 28, height: 26)
                        .tint(.white)
                        .padding(.bottom, 4)
                        .padding(.leading, 4)
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .frame(width: 60, height: 60)
    }
}

#Preview {
    CheckMarkButton(color: .blue,
                    isDone: true,
                    action: {})
}
