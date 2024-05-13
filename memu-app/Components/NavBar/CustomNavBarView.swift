//
//  CustomNavBarView.swift
//  memu-app
//
//  Created by Jonathan on 9/5/2024.
//

import SwiftUI

struct CustomNavBarView: View {
    @State var title: String
    @Environment(\.dismiss) var dismissView
    
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
                    Button(action: {
                        dismissView()
                    }, label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .foregroundStyle(.white)
                            .frame(width: 15, height: 20)
                    })
                    
                    Text(title)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                    Spacer()
                }
                .padding()
            }
        }
        .frame(height: 170)
        .ignoresSafeArea()
        .position(x: 214.9, y: 0)
    }
}

#Preview {
    CustomNavBarView(title: "Title")
}
