//
//  SwitchCameraButton.swift
//  memu-app
//
//  Created by Duy Nguyen on 30/5/2024.
//

import SwiftUI

struct SwitchCameraButton: View {
    
    @State var switchable: Bool
    var action: (() -> Void)?
    
    var body: some View {
        Button(action: { action?() }) {
            ZStack {
                Circle()
                    .frame(width: 50, height: 50)
                    .foregroundColor(switchable ? .blue : .gray) // Gray out the button when capturing
                    .overlay(
                        Circle()
                            .stroke(.blue, lineWidth: 4)
                            .scaleEffect(1.5)
                            .opacity(0)
                    )
                Image(systemName: "arrow.triangle.2.circlepath")
                    .foregroundColor(.white)
            }
        }
        .contentShape(.circle)
        .disabled(!switchable)
    }
}

#Preview {
    SwitchCameraButton(switchable: false)
}
