//
//  CameraPreviewController.swift
//  memu-app
//
//  Created by Duy Nguyen on 13/5/2024.
//

import SwiftUI
import AVFoundation

struct CameraPreview: UIViewRepresentable {
    
    let session: AVCaptureSession
    
    func makeUIView(context: Context) -> VideoPreviewView {
        let view = VideoPreviewView()
        view.backgroundColor = .black
        view.session = session
        view.videoPreviewLayer.videoGravity = .resizeAspectFill
        return view
    }
    
    func updateUIView(_ uiView: VideoPreviewView, context: Context) {
        uiView.session = session
    }
    
    class VideoPreviewView: UIView {
        override class var layerClass: AnyClass {
            return AVCaptureVideoPreviewLayer.self
        }
        
        var videoPreviewLayer: AVCaptureVideoPreviewLayer {
            return layer as! AVCaptureVideoPreviewLayer
        }
        
        var session: AVCaptureSession? {
            get { return videoPreviewLayer.session }
            set { videoPreviewLayer.session = newValue }
        }
    }
}
