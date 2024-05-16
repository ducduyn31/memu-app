//
//  TranslatorView.swift
//  memu-app
//
//  Created by Kane Thuong on 11/5/2024.
//

import SwiftUI
import Combine
import SwiftTTSCombine

struct TranslatorView: View {
    // Using AppStorage to store the user's name
    // The name will be displayed on the top of the screen
    @AppStorage("name") var name: String = ""
    
    // This text will be updated with the full text over time
    @State private var displayText = "Waiting for input..."
    let fullText = """
    Excuse me, could you help me find where the organic produce section is, and also let me know if you have any gluten-free bread and non-dairy milk options in stock, as well as whether there are any current promotions or discounts on these items?
    """.components(separatedBy: " ")
    @State private var currentIndex = 0
    @State private var timer: Timer? = nil
    @State private var isCapturing = false
    @State private var isSpeaking = false
    @ObservedObject var viewModel = CameraViewModel()

    // Using SwiftTTS for text-to-speech functionality
    let engine: TTSEngine = SwiftTTSCombine.Engine()
    @State var cancellables = Set<AnyCancellable>()
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                HStack {
                    Text(displayText)
                        .font(.title)
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding()
                CameraPreview(session: viewModel.session)
                    .frame(height: max( UIScreen.main.bounds.height / 2, 400))
                HStack {
                    Rectangle()
                    .opacity(0)
                    .frame(width: 60, height: 60)
                    .cornerRadius(24)
                    Spacer()
                    GlowButton(action: {
                        // Start or stop the text update process based on the current state
                        if isCapturing {
                            stopTextUpdateProcess()
                            isCapturing = false
                        } else {
                            startTextUpdateProcess()
                            isCapturing = true
                        }
                        
                    }, size: 60)
                    Spacer()
                    // Switch camera button
                    Button(action: {
                        viewModel.switchCamera()
                    }) {
                        ZStack {
                            Circle()
                                .frame(width: 50, height: 50)
                                .foregroundColor(isCapturing ? .gray : .blue) // Gray out the button when capturing
                                .overlay(
                                    Circle()
                                        .stroke(.blue, lineWidth: 4)
                                        .scaleEffect(1.5)
                                        .opacity(0)
                                )
                            Image(systemName: "arrow.triangle.2.circlepath")
                                .foregroundColor(.white)
                        }
                    }
                    .contentShape(.circle)
                    .disabled(isCapturing) // Disable switch camera button when capturing
                }
                .padding()
                .padding(.trailing, 20)
            }
            CustomNavBarView(title: "Hi, \(name)!", hasBackButton: false, offsetY: 10)
        }
        .onAppear {
            viewModel.checkForPermissions()
        }
    }
    
    func startTextUpdateProcess() {
        // Reset state for restart
        displayText = ""
        currentIndex = 0
        timer?.invalidate() // Invalidate any existing timer

        // Initial delay of 300ms before starting the timer
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { _ in
                if !isSpeaking{ //check if text to speech is currently active
                    updateText()
                }
            }
        }
    }
    
    func stopTextUpdateProcess() {
        // Reset state for restart
        displayText = "Waiting for input..."
        currentIndex = 0
        timer?.invalidate() // Invalidate any existing timer
    }
    
    // Update the text to be displayed
    func updateText() {
        let numberOfWords = Int.random(in: 2...4)
        let endIndex = min(currentIndex + numberOfWords, fullText.count)
        let selectedWords = fullText[currentIndex..<endIndex].joined(separator: " ")
        
        if currentIndex < fullText.count {
            displayText = currentIndex > 0 ? " \(selectedWords)" : selectedWords
            //activate text-to-speech
            engine.speak(string: displayText)
            currentIndex = endIndex
            
            //listener for text to speech. isSpeaking will become false when the speech has finished 
            engine.isSpeakingPublisher
                .sink { isSpeaking in
                    self.isSpeaking = isSpeaking
                }
                .store(in: &cancellables)
            
        } else {
            timer?.invalidate() // Stop the timer once we reach the end of the text
        }
    }
}

#Preview {
    TranslatorView()
}
