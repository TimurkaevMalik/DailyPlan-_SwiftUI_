//
//  TabBarButton.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 17.08.2024.
//

import SwiftUI

struct TabBarButton: View {
    
    var action: () -> Void
    var imageName: String
    var buttonText: String
    var buttonColor: Color
    var isActive: Bool
    
    var body: some View {
        
        Button {
            action()
        } label: {
            
            GeometryReader { geo in
                
                if isActive {
                    Rectangle()
                        .foregroundColor(.blue)
                        .frame(width: geo.size.width/2.3, height: 4)
                        .padding(.leading, geo.size.width/4)
                        .cornerRadius(10)
                }
                
                VStack (alignment: .center, spacing: 4) {
                    
                    Image(systemName: imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    
                    Text(buttonText)
                        .font(Font.tabBar)
                }
                .frame(width: geo.size.width, height: geo.size.height)
            }
        }
        .tint(buttonColor)
    }
}

#Preview {
    TabBarButton(action: {print("action")}, imageName: "list.bullet.circle", buttonText: "Tasks", buttonColor: .iconsSecondary, isActive: true)
}
