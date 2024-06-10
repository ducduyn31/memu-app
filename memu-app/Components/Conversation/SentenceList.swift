//
//  SentenceList.swift
//  memu-app
//
//  Created by David on 13/5/2024.
//

import SwiftUI

struct SentenceList: View {
    let historySession : HistorySession
    var body: some View {
        ScrollView {
            ForEach(historySession.messages, id: \.self) { message in
                SentenceItem(content: message.content)
            }
        }
    }
}

#Preview {
    SentenceList(historySession: HistorySession(imagePath: "Avatar1", lastTime: "18:31", lastMessage: "Can I have a bottle of water?"))
}
