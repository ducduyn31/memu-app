//
//  HistoryListItem.swift
//  memu-app
//
//  Created by David on 8/5/2024.
//

import SwiftUI

// HistoryListItem is a SwiftUI View that represents a single item in the history list.
struct HistoryListItem: View {
    // isSelected is a state variable that determines whether the item is selected.
    @State var isSelected = false
    // session is a variable that holds the details of the history session.
    var session: HistorySession?
    // itemHeight is a constant that sets the height of the item.
    let itemHeight = 100.0
    
    var body: some View {
         // Custom navigation link that navigates to the destination view when clicked.
        CustomNavLink (
            title: "Conversation",
            destination: HistorySessionView(historySession: session!)
        )
        {
            ZStack {
                // The Image displays the avatar of the session.
                HStack {
                    Image(session?.imagePath ?? "Avatar1")
                        .resizable()
                        .frame(width:64,height:64)
                        .clipShape(.circle)
                        .padding()
                    VStack {
                        // The Text displays the last time the session was active.
                        HStack {
                            Spacer()
                            Text(session?.getLastTime() ?? "")
                                .font(.subheadline)
                        }
                        .padding([.top, .trailing], 20)
                        // The Text displays the last message in the session.
                        HStack {
                            Text(session?.getLastMessage() ?? "")
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
                .padding([.leading, .trailing], 20)
            }
            .frame(height: itemHeight)
        }
        
    }
}

#Preview {
    HistoryListItem(session: HistorySession(imagePath: "Avatar1", lastTime: "18:31", lastMessage: "Can I have a bottle of water?"))
}
