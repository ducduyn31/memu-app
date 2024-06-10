//
//  HistorySession.swift
//  memu-app
//
//  Created by David on 9/5/2024.
//

import Foundation
import SwiftUI

struct Message: Identifiable, Codable, Hashable {
    let id: Int?
    let content: String
    let time: Date
    
    enum CodingKeys: String, CodingKey{
        case id = "id"
        case content = "content"
        case time = "created_at"
    }
}

// HistorySession is a struct that represents a history session.
struct HistorySession: Identifiable, Codable, Hashable {
    var id: Int?   // Unique identifier for each history session
    
    // Default properties for a history session
    var imagePath: String = "Avatar1"  // Path to the image for the session
    var videoUrl: String
    var messages: [Message]
    
    enum CodingKeys: String, CodingKey{
        case id = "id"
        case messages = "message"
        case videoUrl = "video"
    }
    
    func getLastMessage() -> String{
        return messages.last?.content ?? "";
    }
    
    func getLastTime() -> String{
        var dateFormatter = DateFormatter();
        dateFormatter.dateFormat = "hh:mm"
        return dateFormatter.string(from: messages.last?.time ?? Date())
    }
    
    init(imagePath: String, lastTime: String, lastMessage: String){
        self.imagePath = imagePath
        messages = [Message(id: 1, content: lastMessage, time: Date())]
        id = 1
        videoUrl = "https://nqoqcwftrvbqelynyuuw.supabase.co/storage/v1/object/public/video/20240610/sample.mp4"
    }
}
