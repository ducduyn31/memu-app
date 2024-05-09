//
//  HistoryList.swift
//  memu-app
//
//  Created by David on 8/5/2024.
//

import SwiftUI

struct HistoryList: View {
    var history: [HistorySession] = []
    
    var body: some View {
        ScrollView {
            ForEach(history) { historySession in
                HistoryListItem(session: historySession)
            }
        }
    }
}

#Preview {
    HistoryList(history: [
        HistorySession(imagePath: "Avatar1", lastTime: "18:31", lastMessage: "Can I have a bottle of water"),
        HistorySession(imagePath: "Avatar1", lastTime: "18:31", lastMessage: "Can I have a bottle of water"),
        HistorySession(imagePath: "Avatar1", lastTime: "18:31", lastMessage: "Can I have a bottle of water"),
        HistorySession(imagePath: "Avatar1", lastTime: "18:31", lastMessage: "Can I have a bottle of water"),
        HistorySession(imagePath: "Avatar1", lastTime: "18:31", lastMessage: "Can I have a bottle of water"),
    ])
}
