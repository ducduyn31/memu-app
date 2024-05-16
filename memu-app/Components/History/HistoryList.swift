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
                .onDelete(perform: delete) // Enable swipe to delete
            }
        }
    }
    
    // Function to delete a conversation from the history list
    func delete(at offsets: IndexSet) {
        history.remove(atOffsets: offsets)
    }
}
