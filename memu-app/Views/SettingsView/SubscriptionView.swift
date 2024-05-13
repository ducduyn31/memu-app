//
//  SubscriptionView.swift
//  memu-app
//
//  Created by Jonathan on 9/5/2024.
//

import SwiftUI

struct SubscriptionView: View {
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 60)
                        .fill(.purple)
                    VStack(spacing: 0){
                        HStack {
                            Image(systemName:"hand.thumbsup.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundStyle(.white)
                                .padding([.leading,.trailing])
                            Text("Memu Nitro")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Spacer()
                        }
                        Text("""
                            - Multi Language Support
                            - Faster Translation
                            - Speech/Text to Sign Language Support
                            """)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 350, alignment: .leading)
                        .padding()
                        Text("AU$30 / month")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                }.frame(height: 350)
            }
            Spacer()
            .padding(.top, 150)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SubscriptionView()
}
