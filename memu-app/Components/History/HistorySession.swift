//
//  HistorySession.swift
//  memu-app
//
//  Created by David on 9/5/2024.
//

import Foundation
import SwiftUI

// HistorySession is a struct that represents a history session.
struct HistorySession: Identifiable {
    var id = UUID()   // Unique identifier for each history session
    
    // Default properties for a history session
    var imagePath: String = "Avatar1"  // Path to the image for the session
    var lastTime: String = "18:18"     // Last time the session was active
    var lastMessage: String = "Store Apple at Hay Market"  // Last message in the session
    let videoUrl: String = "https://videos.pexels.com/video-files/5212265/5212265-uhd_3840_2160_25fps.mp4"  // URL to a video related to the session
    var conversations: [String] = selectRandomItems(from: grocerySentences, count: 20)  // Array of conversation strings in the session
    
    // Initializer that takes an array of conversation strings
    init(conversations: [String]) {
        self.conversations = conversations
    }
    
    // Initializer that takes an image path, last time, and last message
    init(imagePath: String, lastTime: String, lastMessage: String) {
        self.imagePath = imagePath
        self.lastTime = lastTime
        self.lastMessage = lastMessage
    }
    
    // Default initializer that sets the conversations to a default array of strings
    init() {
        self.conversations = [
            "Ask about our catering services for your next event.",
            "Visit our bakery for custom cake designs.",
            "Our store is committed to sustainability and green practices.",
        ]
    }
}
