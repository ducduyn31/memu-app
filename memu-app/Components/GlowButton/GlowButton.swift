//
//  GlowButton.swift
//  memu-app
//
//  Created by David on 12/5/2024.
//

import SwiftUI

// GlowButton is a SwiftUI View that represents a button with a glowing effect.
struct GlowButton: View {
    // State variables to control the glowing and pressed state of the button.
    @State private var isGlowing = false
    @State private var isPressed = false

    // Properties for the button label, action when pressed, and size.
    var label: String = ""
    var action: () -> Void = {}
    var size: CGFloat = 160

    // The body of the GlowButton view.
    var body: some View {
        // The button's action toggles the isPressed state and performs the provided action.
        Button(action: {
            isPressed.toggle()
            action()
        })
        {
            // The button is a ZStack with a Circle and a Text.
            ZStack {
                // The Circle changes color when pressed and has a glowing effect.
                Circle()
                    .frame(width: size, height: size)
                    .foregroundColor(isPressed ? .red : .blue)
                    .overlay(
                        Circle()
                            .stroke(.blue, lineWidth: 4)
                            .scaleEffect(isGlowing ? 1.5 : 1)
                            .opacity(isGlowing && isPressed ? 0 : 1)
                            // The glowing effect is an animation that repeats forever.
                            .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: false), value: isGlowing)
                    )
                    // The Text displays the button's label.
                    Text(label)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
            }
        }
        // The button starts glowing when it appears.
        .onAppear {
            isGlowing = true
        }
    }
}

// A preview of the GlowButton with a size of 60.
#Preview {
    GlowButton(size: 60)
}
