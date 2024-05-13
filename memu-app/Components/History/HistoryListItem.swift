//
//  HistoryListItem.swift
//  memu-app
//
//  Created by David on 8/5/2024.
//

import SwiftUI

struct HistoryListItem: View {
    @State var isSelected = false
    var session: HistorySession?
    let itemHeight = 100.0
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(isSelected ? .blue.opacity(0.2) : .blue.opacity(0))
                .frame(height: itemHeight)
                .cornerRadius(24)
                .padding()
            
            HStack {
                Image(session?.imagePath ?? "Avatar1")
                    .resizable()
                    .frame(width:64,height:64)
                    .clipShape(.circle)
                    .padding()
                VStack {
                    HStack {
                        Spacer()
                        Text(session?.lastTime ?? "")
                            .font(.subheadline)
                    }
                    .padding([.top, .trailing], 20)
                    HStack {
                        Image (systemName: isSelected ? "speaker.wave.2.fill" : "speaker.wave.2")
                            .foregroundColor(.blue)
                        Text(session?.lastMessage ?? "")
                            .font(.body)
                            .foregroundColor(.black)
                            .fontWeight(.regular)
                            .lineLimit(1)
                            .frame(width: 200, alignment: .leading)
                        Spacer()
                    }
                    Spacer()
                }
                .frame(height: itemHeight)
                Spacer()
            }
            .onTapGesture {
                isSelected.toggle()
            }
            .padding([.leading, .trailing], 20)
        }
        .frame(height: itemHeight)
    }
}

#Preview {
    HistoryListItem(session: HistorySession(imagePath: "Avatar1", lastTime: "18:31", lastMessage: "Can I have a bottle of water?"))
}
