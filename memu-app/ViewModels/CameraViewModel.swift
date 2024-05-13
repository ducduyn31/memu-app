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
    
    func checkForPermissions() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch status {
            case .authorized:
                isPermissionGranted = true
                configureSession()
            case .notDetermined:
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
}
