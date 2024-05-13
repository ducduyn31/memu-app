//
//  SentenceItemView.swift
//  memu-app
//
//  Created by David on 13/5/2024.
//

import SwiftUI
import AVFoundation

struct SentenceItem: View {
    let itemHeight = 100.0
    let content : String
    @State var isSelected = false
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .fill(isSelected ? .blue.opacity(0.2) : .blue.opacity(0))
                .frame(height: itemHeight)
                .padding()
                .overlay (
                    RoundedRectangle(cornerRadius: 24, style: RoundedCornerStyle.continuous)
                        .stroke(.blue)
                        .frame(height: itemHeight)
                        .padding()
                )
                
            
            HStack (
                alignment: .center
            ) {
                Image (systemName: isSelected ? "speaker.wave.2.fill" : "speaker.wave.2")
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                
                Text(content)
                    .font(.system(size: 16))
                    .padding()
                    .font(.body)
                    .foregroundColor(.black)
                    .fontWeight(.regular)
                    .lineLimit(2)
                    .frame(width: 290, alignment: .leading)
            }
            .onTapGesture {
                isSelected.toggle()
                if isSelected {
                    let utterance = AVSpeechUtterance(string: content)
                    let voice = AVSpeechSynthesisVoice(language: "en-GB")
                    utterance.voice = voice
                    let synthesizer = AVSpeechSynthesizer()
                    synthesizer.speak(utterance)
                }
            }
        }
    }
}

#Preview {
    SentenceItem(content: "Fresh seafood arrives every Thursday afternoon.")
}
