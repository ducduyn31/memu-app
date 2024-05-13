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
            ForEach(historySession.conversations, id: \.self) { conversation in
                SentenceItem(content: conversation)
            }
        }
    }
}

#Preview {
    SentenceList(historySession: HistorySession(conversations: [
        "Ask about our catering services for your next event.",
        "Visit our bakery for custom cake designs.",
        "Our store is committed to sustainability and green practices.",
        "We offer a wide selection of organic baby foods.",
        "Try our freshly brewed coffee at the café corner.",
        "Need dinner ideas? Pick up one of our ready-to-cook meal kits.",
        "Check the end of aisles for clearance items and great deals.",
        "Our store-brand cereals are both delicious and affordable.",
        "Sign up for our newsletter to receive weekly specials.",
    ]))
}
