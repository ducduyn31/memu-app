//
//  HistorySession.swift
//  memu-app
//
//  Created by David on 9/5/2024.
//

import Foundation
import SwiftUI

struct HistorySession: Identifiable {
    var id = UUID()
    
    var imagePath: String = "Avatar1"
    var lastTime: String = "18:18"
    var lastMessage: String = "Store Apple at Hay Market"
    let videoUrl: String = "https://video-previews.elements.envatousercontent.com/h264-video-previews/315b5d0f-cca5-41c0-824f-e99e2dcfbe6d/40108191.mp4"
    var conversations: [String] = selectRandomItems(from: grocerySentences, count: 20)
    
    init(conversations: [String]) {
        self.conversations = conversations
    }
    
    init(imagePath: String, lastTime: String, lastMessage: String) {
        self.imagePath = imagePath
        self.lastTime = lastTime
        self.lastMessage = lastMessage
    }
    
    init() {
        self.conversations = [
            "Ask about our catering services for your next event.",
            "Visit our bakery for custom cake designs.",
            "Our store is committed to sustainability and green practices.",
        ]
    }
}
