//
//  Conversation.swift
//  memu-app
//
//  Created by Jonathan on 10/6/2024.
//

import Foundation

class HistoryManager: ObservableObject{
    @Published var historySessions = [HistorySession]()
    
    func loadHistory() async throws{
//        let historySessions : [HistorySession] = try await supabase
//            .from("conversation")
//            .select(
//              """
//                id,
//                video,
//                message (
//                  id, content, created_at
//                )
//              """
//            )
//            .order("created_at", ascending: true, referencedTable: "message")
//            .execute()
//            .value
//        
//        DispatchQueue.main.async {
//            self.historySessions = historySessions
//        }
    }
}

func main() async{
    var historyManager = HistoryManager()
    try? await historyManager.loadHistory()
}

