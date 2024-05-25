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
                    Spacer()
                    Spacer().frame(width: 60)
                    GlowButton(isTriggered: $isCapturing, size: 60) { triggered in
                        // Start or stop the text update process based on the current state
                        if triggered != nil {
                            viewModel.sendUpstream()
                        } else {
                            viewModel.cancelUpstream()
                        }
                    }
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
            CustomNavBarView(title: "Hi, \(name)!", initialOffsetY: 85, hasBackButton: false)
        }
        .onAppear {
            // Check for camera permissions when the view appears
            viewModel.checkForPermissions()
        }
    }
}

#Preview {
    TranslatorView()
}
