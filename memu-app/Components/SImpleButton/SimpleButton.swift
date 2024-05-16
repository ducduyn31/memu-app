//
//  SimpleButton.swift
//  memu-app
//
//  Created by Jonathan on 8/5/2024.
//

import SwiftUI

//a component to represent a button in the app
struct SimpleButton: View {
    var label: String = ""
    var action: () -> Void = {}
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(label)
                .font(.title2)
                .fontWeight(.bold)
                .frame(maxWidth: 350)
                .frame(height: 55)
                .background(.blue)
                .foregroundStyle(.white)
                .padding()
        }
    }
}

#Preview {
    SimpleButton(label: "Confirm")
}
