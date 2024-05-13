//
//  GlowButton.swift
//  memu-app
//
//  Created by David on 12/5/2024.
//

import SwiftUI

struct GlowButton: View {
    @State private var isGlowing = false
    @State private var isPressed = false
    var label: String = ""
    var action: () -> Void = {}
    var size: CGFloat = 160

    var body: some View {
        Button(action: {
            isPressed.toggle()
            action()
        }) 
        {
            ZStack {
                Circle()
                    .frame(width: size, height: size)
                    .foregroundColor(isPressed ? .red : .blue)
                    .overlay(
                        Circle()
                            .stroke(.blue, lineWidth: 4)
                            .scaleEffect(isGlowing ? 1.5 : 1)
                            .opacity(isGlowing && isPressed ? 0 : 1)
                            .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: false), value: isGlowing)
                    )
                    Text(label)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
            }
        }
        .onAppear {
            isGlowing = true
        }
    }
}

#Preview {
    GlowButton(size: 60)
}
