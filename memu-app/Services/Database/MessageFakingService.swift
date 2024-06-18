//
//  SupabaseService.swift
//  memu-app
//
//  Created by Jonathan on 10/6/2024.
//

import Foundation
import Supabase
import SwiftTTSCombine


class MessageFakingService: ObservableObject {
    
    @Published var lastMessage = ""
    @Published var isLoading = false
    
    private let client: SupabaseClient
    private static let messageChannel = "realtime:message"
    private var channel: RealtimeChannelV2?
    let ttsEngine: TTSEngine =  SwiftTTSCombine.Engine()
    
    init() {
        client = SupabaseClient(
            supabaseURL: URL(string: "https://nqoqcwftrvbqelynyuuw.supabase.co")!,
            supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5xb3Fjd2Z0cnZicWVseW55dXV3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTc2NjUzNzIsImV4cCI6MjAzMzI0MTM3Mn0.G7Q16PDlLCLMrIZtRozkNlXlLShbH1nmd8TFhjH8iPI"
        )
    }
    
    public func subscribeRealtimeMessage() async {
        lastMessage = ""
        channel = await client.channel(MessageFakingService.messageChannel)
        let broadcastStream = await channel!.broadcastStream(event: "message")
        let loadingStream = await channel!.broadcastStream(event: "loading")
        await channel!.subscribe()
        print("Subscribed to channel: \(MessageFakingService.messageChannel)")
        
        Task {
            for await message in broadcastStream {
                DispatchQueue.main.async {
                    self.lastMessage = message["payload"]?.objectValue!["message"]?.stringValue ?? ""
                    self.isLoading = false
                    self.ttsEngine.speak(string: self.lastMessage)
                }
            }
        }
        
        Task {
            for await message in loadingStream {
                DispatchQueue.main.async {
                    self.isLoading = true
                }
            }
        }
    }
    
    public func unSubscribeRealtimeMessage() async {
        await client.removeAllChannels()
        lastMessage = ""
    }
    
    
}
