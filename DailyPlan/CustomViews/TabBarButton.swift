//
//  TabBarButton.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 17.08.2024.
//

import SwiftUI

struct TabBarButton: View {
    
    let action: () -> Void
    let imageName: String
    let buttonText: String
    let buttonColor: Color
    let isActive: Bool
    
    var body: some View {
        
        Button {
            action()
        } label: {
            
            GeometryReader { geo in
                
                VStack(alignment: .center, spacing: 0) {
                    
                    if isActive {
                        Rectangle()
                            .foregroundColor(.blue)
                            .frame(width: geo.size.width/2.3, height: 4)
                        
                            .clipShape(.rect(
                                topLeadingRadius: 0,
                                bottomLeadingRadius: 20,
                                bottomTrailingRadius: 20,
                                topTrailingRadius: 0))
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
}

#Preview {
    TabBarButton(action: {print("action")}, imageName: "list.bullet.circle", buttonText: "Tasks", buttonColor: .iconsSecondary, isActive: true)
}
