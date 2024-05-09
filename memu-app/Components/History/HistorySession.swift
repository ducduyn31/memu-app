//
//  HistorySession.swift
//  memu-app
//
//  Created by David on 9/5/2024.
//

import Foundation

struct HistorySession: Identifiable {
    var id = UUID()
    
    let imagePath: String
    let lastTime: String
    let lastMessage: String
}
