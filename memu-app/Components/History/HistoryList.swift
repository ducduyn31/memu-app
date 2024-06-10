//
//  HistoryList.swift
//  memu-app
//
//  Created by David on 8/5/2024.
//

import SwiftUI

struct HistoryList: View {
    @StateObject var historymanager = HistoryManager()
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(historymanager.historySessions) { historySession in
                    HistoryListItem(session: historySession)
                }
                .onDelete(perform: delete) // Enable swipe to delete
            }
        }
        .task {
            try? await historymanager.loadHistory()
        }
    }
    
    // Function to delete a conversation from the history list
    func delete(at offsets: IndexSet) {
        historymanager.historySessions.remove(atOffsets: offsets)
    }
}

#Preview {
   HistoryList()
}
