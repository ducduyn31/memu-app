//
//  CameraViewModel.swift
//  memu-app
//
//  Created by Duy Nguyen on 13/5/2024.
//

import Foundation
import AVFoundation
import SwiftUI

class CameraViewModel: ObservableObject {
    
    @ObservedObject var cameraManager = CameraService()
    
    @Published var isFlashOn = false
    @Published var showAlertError = false
    @Published var alertError: AlertError?
    @Published var showSettingAlert = false
    @Published var isPermissionGranted = false
    
    var session: AVCaptureSession = .init()

    init() {
        session = cameraManager.captureSession
    }
    
    deinit {
        cameraManager.stopCaptureSession()
    }
    
    
    func configureSession() {
        cameraManager.configureSession()
    }
    
    /// Check for camera permission, including photo library permission
    /// If the permission is not granted, it will show an alert to ask for permission
    func checkForPermissions() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch status {
            case .authorized:
            // The user has previously granted access to the camera.
                isPermissionGranted = true
                configureSession()
            case .notDetermined:
            // The user has not yet been asked for camera access.
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    DispatchQueue.main.async {
                        if granted {
                            self.isPermissionGranted = true
                            self.configureSession()
                        } else {
                            self.showSettingAlert = true
                        }
                    }
                }
            default:
                isPermissionGranted = false
                showAlertError = true
        }
    }
    
    func switchCamera() {
        cameraManager.switchCamera()
    }
    
    func capturePhoto() {
        cameraManager.captureImage()
    }
    
    func sendUpstream() {}
    
    func cancelUpstream() {}
}
