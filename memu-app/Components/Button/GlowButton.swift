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
    @Binding var isTriggered: Bool

    // Properties for the button label, action when pressed, and size.
    let disabled: Bool
    var label: String = ""
    var size: CGFloat = 160
    var action: (Bool?) -> Void

    // The body of the GlowButton view.
    var body: some View {
        // The button's action toggles the isPressed state and performs the provided action.
        Button(action: toggleState) {
            // The button is a ZStack with a Circle and a Text.
            ZStack {
                // The Circle changes color when pressed and has a glowing effect.
                createMainCircle()
                    .overlay(
                        Group {
                            if !disabled {
                                createOverlayCircle()
                            }
                        }
                    )
                // The Text displays the button's label.
               createLabel()
            }
        }
        .disabled(disabled)
        // The button starts glowing when it appears.
        .onAppear {
            isGlowing = true
        }
    }
    
    private func toggleState() {
        isTriggered.toggle()
        action(isTriggered)
    }
    
    private func createMainCircle() -> some View {
        Circle()
        .frame(width: size, height: size)
        .foregroundColor(disabled ? .gray : (isTriggered ? Color.red : Color.blue))
    }
    
    private func createOverlayCircle() -> some View {
        Circle()
        .stroke(.blue, lineWidth: 4)
        .scaleEffect(isGlowing ? 1.5 : 1)
        .opacity(isGlowing && isTriggered ? 0 : 1)
        .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: false), value: isGlowing)
    }
    
    private func createLabel() -> some View {
        Text(label)
        .font(.title)
        .fontWeight(.bold)
        .foregroundColor(.white)
    }
    
    private func startGlowing() {
        isGlowing = true
    }
}

// A preview of the GlowButton with a size of 60.
#Preview {
    GlowButton(isTriggered: .constant(false), disabled: false, size: 60) { _ in }
}
