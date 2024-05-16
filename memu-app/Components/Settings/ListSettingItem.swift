//
//  ListSettingItem.swift
//  memu-app
//
//  Created by David on 8/5/2024.
//

import SwiftUI

// ListSettingItem is a SwiftUI View that represents a single setting item in a list.
struct ListSettingItem: View {
    // The session variable holds the details of the setting item.
    var session: ListSettingSession? = nil
    // The itemHeight variable sets the height of the setting item.
    let itemHeight = 100.0
    
    // The body of the ListSettingItem view.
    var body: some View {
        // CustomNavLink is a custom SwiftUI view that navigates to a destination view when tapped.
        CustomNavLink (
            title: session?.titleMessage ?? "title",
            destination: session?.getScreen()
        ){
            // The content of the navigation link is a ZStack with a Rectangle and an HStack.
            ZStack {
                // The Rectangle is invisible and is used to set the height of the setting item.
                Rectangle()
                    .opacity(0)
                    .frame(height: itemHeight)
                    .padding()
                // The HStack contains an Image, a Text, another Image, and a Spacer.
                HStack {
                    // The first Image is the icon of the setting item.
                    Image(systemName: session?.imageName ?? "person.crop.circle")
                        .foregroundColor(.blue)
                        .frame(width: 24, height: 24)
                        .padding()
                    // The Text is the titleMessage of the session.
                    Text(session?.titleMessage ?? "Account")
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .fontWeight(.medium)
                        .lineLimit(1)
                        .frame(width: 300, alignment: .leading)
                    // The second Image is a chevron pointing to the right.
                    Image (systemName:"control")
                        .rotationEffect(.degrees(90))
                    Spacer()
                }
                Spacer()
            }
            // The height of the ZStack is set to itemHeight.
            .frame(height: itemHeight)
        }
    }
}

#Preview {
    ListSettingItem()
}
