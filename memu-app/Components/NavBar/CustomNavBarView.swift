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
    var hasBackButton: Bool = true
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
                    if hasBackButton {
                        
                        Button(action: {
                            dismissView()
                        }, label: {
                            Image(systemName: "chevron.left")
                                .resizable()
                                .foregroundStyle(.white)
                                .frame(width: 15, height: 20)
                        })
                    }
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
        .frame(width: UIScreen.main.bounds.width, height: 170)
        .ignoresSafeArea()
        .position(x: UIScreen.main.bounds.width / 2, y: offsetY)
    }
}

#Preview {
    CustomNavBarView(title: "Title")
}
