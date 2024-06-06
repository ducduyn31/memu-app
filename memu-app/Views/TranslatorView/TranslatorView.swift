//
//  TranslatorView.swift
//  memu-app
//
//  Created by Kane Thuong on 11/5/2024.
//

import SwiftUI
import Combine
struct TranslatorView: View {
    // Using AppStorage to store the user's name
    // The name will be displayed on the top of the screen
    @AppStorage("name") var name: String = ""

    // This text will be updated with the full text over time
    @State private var isCapturing = false
    @ObservedObject var viewModel = CameraViewModel()

    @State var cancellables = Set<AnyCancellable>()
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                displayTextView()
                if viewModel.loading {
                    loadingView()
                } else {
                    cameraPreview()
                }
                actionButtonsView()
            }
            customNavBarView()
        }
        .onAppear {
            // Check for camera permissions when the view appears
            viewModel.checkForPermissions()
        }
    }
    
    @ViewBuilder
    private func displayTextView() -> some View {
        HStack {
            Text(viewModel.translatedText)
                .font(.title)
                .foregroundColor(.gray)
            Spacer()
        }
        .padding()
    }
    
    @ViewBuilder
    private func loadingView() -> some View {
        Spacer()
        ProgressView("It should takes 30 seconds")
        Spacer()
    }
    
    @ViewBuilder
    private func cameraPreview() -> some View {
        CameraPreview(session: viewModel.session)
            .frame(height: max( UIScreen.main.bounds.height / 2, 400))
    }
    
    @ViewBuilder
    private func actionButtonsView() -> some View {
        HStack {
            Spacer()
            Spacer().frame(width: 60)
            GlowButton(isTriggered: $isCapturing, disabled: viewModel.loading, size: 60) { triggered in
                handleGlowButtonPress(triggered)
            }
            Spacer()
            // Switch camera button
            SwitchCameraButton(switchable: !isCapturing) {
                viewModel.switchCamera()
            }
        }
        .padding()
        .padding(.trailing, 20)
    }
    
    @ViewBuilder
    private func customNavBarView() -> some View {
        CustomNavBarView(title: "Hi, \(name)!", initialOffsetY: 85, hasBackButton: false)
    }
    
    private func handleGlowButtonPress(_ triggered: Bool?) {
        if triggered != nil && triggered! {
            viewModel.startRecordingVideo()
        } else {
            viewModel.stopRecordingVideo()
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
