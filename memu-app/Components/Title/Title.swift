//
//  Title.swift
//  memu-app
//
//  Created by Jonathan on 7/5/2024.
//

import SwiftUI

struct Title: View {
    var label: String = ""
    var offsetY: Double = 85
    
    var body: some View {
        ZStack {
            UnevenRoundedRectangle()
                .fill(.blue)
                .clipShape(
                    .rect(
                        topLeadingRadius: 0,
                        bottomLeadingRadius: 60,
                        bottomTrailingRadius: 60,
                        topTrailingRadius: 0
                    )
                )
            VStack {
                Spacer()
                HStack {
                    Text(label)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                    Spacer()
                }
                .padding()
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: 170)
        .ignoresSafeArea()
        .position(x: UIScreen.main.bounds.width / 2, y: offsetY)
    }
}

#Preview {
    Title(label: "Title")
}

