//
//  TranslatorView.swift
//  memu-app
//
//  Created by Kane Thuong on 11/5/2024.
//

import SwiftUI

struct TranslatorView: View {
    @AppStorage("name") var name: String = ""
    
    @State private var displayText = "Waiting for input..."
    let fullText = """
    What I gotta do to get it through to you? I'm superhuman
    I'm innovative and I'm made of rubber so that anything
    You say is ricochetin' off of me, and it'll glue to you and
    I'm devastating, more than ever demonstrating
    How to give a motherfuckin' audience a feeling like it's levitating
    Never fading, and I know the haters are forever waiting
    For the day that they can say I fell off, they'll be celebrating
    """.components(separatedBy: " ")
    @State private var currentIndex = 0
    @State private var timer: Timer? = nil
    @ObservedObject var viewModel = CameraViewModel()
    
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
                    Button(action: {}) {
                        Color.gray
                            .opacity(0.2)
                            .overlay(content: {
                                Image(systemName: "photo")
                                    .foregroundColor(.white)
                            })
                    }
                    .frame(width: 60, height: 60)
                    .cornerRadius(24)
                    Spacer()
                    GlowButton(action: {
                        startTextUpdateProcess()
                    }, size: 60)
                    Spacer()
                    Button(action: {
                    }) {
                        ZStack {
                            Circle()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.blue)
                                .overlay(
                                    Circle()
                                        .stroke(.blue, lineWidth: 4)
                                        .scaleEffect(1.5)
                                        .opacity(0)
                                )
                            Image(systemName: "arrow.triangle.2.circlepath")
                                .foregroundColor(.white)
                        }
                    }.contentShape(.circle)
                }
                .padding()
                .padding(.trailing, 20)
            }
            CustomNavBarView(title: "Hi, \(name)!", hasBackButton: false)
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
                updateText()
            }
        }
    }
    
    func updateText() {
        let numberOfWords = Int.random(in: 2...4)
        let endIndex = min(currentIndex + numberOfWords, fullText.count)
        let selectedWords = fullText[currentIndex..<endIndex].joined(separator: " ")
        
        if currentIndex < fullText.count {
            displayText = currentIndex > 0 ? " \(selectedWords)" : selectedWords
            currentIndex = endIndex
        } else {
            timer?.invalidate() // Stop the timer once we reach the end of the text
        }
    }
}

#Preview {
    TranslatorView()
}
