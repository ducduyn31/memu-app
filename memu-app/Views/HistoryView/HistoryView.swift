//
//  HistoryView.swift
//  memu-app
//
//  Created by Kane Thuong on 8/5/2024.
//

import SwiftUI

struct HistoryView: View {
    
    let mockHistory: [HistorySession] = [
        HistorySession(imagePath: "Avatar1", lastTime: "18:31", lastMessage: "Can I have a bottle of water?"),
        HistorySession(imagePath: "Avatar2", lastTime: "16:04", lastMessage: "Can I have a bottle of water?"),
        HistorySession(imagePath: "Avatar3", lastTime: "08:12", lastMessage: "It's really nice to meet you"),
        HistorySession(imagePath: "Avatar4", lastTime: "Yesterday", lastMessage: "Can I have a bottle of water?"),
        HistorySession(imagePath: "Avatar5", lastTime: "Yesterday", lastMessage: "Can I have a bottle of water?"),
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    HistoryList(history: mockHistory)
                }
                .padding(.top, 150)
            }
            .ignoresSafeArea()
            .padding(.top, 150)
            CustomNavBarView(title: "Translation History", hasBackButton: false, offsetY: 50)
        }
        
        
    }
}

 #Preview {
    HistoryView()
}
