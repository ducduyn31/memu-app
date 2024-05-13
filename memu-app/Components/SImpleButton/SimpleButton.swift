//
//  SimpleButton.swift
//  MimuAI
//
//  Created by user on 8/5/2024.
//

import SwiftUI

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
