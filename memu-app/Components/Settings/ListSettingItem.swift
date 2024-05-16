//
//  ListSettingItem.swift
//  memu-app
//
//  Created by David on 8/5/2024.
//

import SwiftUI

struct ListSettingItem: View {
    var session: ListSettingSession? = nil
    let itemHeight = 100.0
    
    var body: some View {
        CustomNavLink (
            title: session?.titleMessage ?? "title",
            destination: session?.getScreen()
        ){
            ZStack {
                Rectangle()
                    .opacity(0)
                    .frame(height: itemHeight)
                    .padding()
                
                HStack {
                    Image(systemName: session?.imageName ?? "person.crop.circle")
                        .foregroundColor(.blue)
                        .frame(width: 24, height: 24)
                        .padding()
                    Text(session?.titleMessage ?? "Account")
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .fontWeight(.medium)
                        .lineLimit(1)
                        .frame(width: 300, alignment: .leading)
                    Image (systemName:"control")
                        .rotationEffect(.degrees(90))
                    Spacer()
                }
                Spacer()
            }
            .frame(height: itemHeight)
        }
    }
}

#Preview {
    ListSettingItem()
}
