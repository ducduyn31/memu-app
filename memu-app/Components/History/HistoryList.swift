//
//  HistoryList.swift
//  memu-app
//
//  Created by David on 8/5/2024.
//

import SwiftUI

struct HistoryList: View {
    @Binding var history: [HistorySession]
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(history) { historySession in
                    HistoryListItem(session: historySession)
                }
                .onDelete(perform: delete)
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        history.remove(atOffsets: offsets)
    }
}

//#Preview {
//    HistoryList(history: [
//        HistorySession(imagePath: "Avatar1", lastTime: "18:31", lastMessage: "Can I have a bottle of water"),
//        HistorySession(imagePath: "Avatar1", lastTime: "18:31", lastMessage: "Can I have a bottle of water"),
//        HistorySession(imagePath: "Avatar1", lastTime: "18:31", lastMessage: "Can I have a bottle of water"),
//        HistorySession(imagePath: "Avatar1", lastTime: "18:31", lastMessage: "Can I have a bottle of water"),
//        HistorySession(imagePath: "Avatar1", lastTime: "18:31", lastMessage: "Can I have a bottle of water"),
//    ])
//}
