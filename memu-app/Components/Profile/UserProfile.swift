//
//  UserProfile.swift
//  memu-app
//
//  Created by David on 7/5/2024.
//

import SwiftUI

// UserProfile is a SwiftUI View that represents a user's profile.
struct UserProfile: View {
    // The body of the UserProfile view.
    var body: some View {
        // The UserProfile view is an HStack that contains an Image, a Text, and a Spacer.
        HStack {
            // The Image displays the user's avatar.
            // It is resizable, has a fixed width and height, is clipped to a circle shape, and has padding.
            Image("Avatar6")
                .resizable()
                .frame(width:64,height:64)
                .clipShape(.circle)
                .padding()
            // The Text displays the user's name.
            // It uses the headline font, has black foreground color, is semi-bold, has a line limit of 1, and is aligned to the leading edge.
            Text("Anna Lee")
                .font(.headline)
                .foregroundColor(.black)
                .fontWeight(.semibold)
                .lineLimit(1)
                .frame(alignment: .leading)
            // The Spacer pushes the HStack to the left.
            Spacer()
        }
    }
}
