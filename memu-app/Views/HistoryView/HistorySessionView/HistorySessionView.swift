//
//  HistorySessionView.swift
//  memu-app
//
//  Created by David on 13/5/2024.
//

import SwiftUI
import AVKit


struct HistorySessionView: View {
    @State private var player = AVPlayer()
    let historySession : HistorySession
    var body: some View {
        ZStack {
            VStack {
                VideoPlayer(player: player)
                .edgesIgnoringSafeArea(.all)
                .navigationBarBackButtonHidden()
                .onAppear {
                    let url = URL(string: "https://videos.pexels.com/video-files/5212265/5212265-uhd_3840_2160_25fps.mp4")!
                    player = AVPlayer(url: url)
                    player.play()
                    
                }
                .onDisappear {
                    player.pause()
                }
                .frame(width: 320, height: 180, alignment: .center)
                
                SentenceList(historySession: historySession)
            }
            .padding(.top, 150)
            Title(label: "Conversation")
                .ignoresSafeArea()
                .position(x: 214.9, y: 50)
                
        }
    }
}

#Preview {
    HistorySessionView(
        historySession: HistorySession(imagePath: "Avatar1", lastTime: "18:31", lastMessage: "Can I have a bottle of water?")
    )
}
