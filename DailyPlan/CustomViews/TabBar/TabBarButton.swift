//
//  TabBarButton.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 17.08.2024.
//

import SwiftUI

struct TabBarButton: View {
    
    let imageName: String
    let buttonText: String
    let buttonColor: Color
    let isActive: Bool
    let action: () -> Void
    
    var body: some View {
        
        Button {
            action()
        } label: {
            GeometryReader { geo in
                VStack(alignment: .center, spacing: 0) {
                    
                    if isActive {
                        makeCursor(geo: geo)
                    }
                    
                    VStack(spacing: 4) {
                        tabItemImage
                        
                        Text(buttonText)
                            .font(Font.tabBar)
                    }
                    .tint(buttonColor)
                    .frame(width: geo.size.width,
                           height: geo.size.height)
                }
            }
        }
    }
}

extension TabBarButton {
    private func makeCursor(geo: GeometryProxy) -> some View {
        Rectangle()
            .foregroundColor(.blue)
            .frame(width: geo.size.width/3, height: 4)
            .clipShape(.rect(
                topLeadingRadius: 0,
                bottomLeadingRadius: 20,
                bottomTrailingRadius: 20,
                topTrailingRadius: 0))
    }
}

private extension TabBarButton {
    var tabItemImage: some View {
        Image(systemName: imageName)
            .resizable()
            .scaledToFit()
            .frame(width: 24, height: 24)
    }
}

#Preview {
    @Previewable @State var isActive = true
    TabBarButton(imageName: "list.bullet.circle",
                 buttonText: "Tasks",
                 buttonColor: .iconsSecondary,
                 isActive: isActive,
                 action: {
        isActive.toggle()
    })
    .frame(width: 100, height: 60)
}
