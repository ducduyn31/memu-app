//
//  CameraViewModel.swift
//  memu-app
//
//  Created by Duy Nguyen on 13/5/2024.
//

import Foundation
import AVFoundation
import SwiftUI
import SwiftTTSCombine
import Alamofire

class CameraViewModel: ObservableObject {
    
    @ObservedObject var cameraManager = CameraService()
    
    @Published var isFlashOn = false
    @Published var showAlertError = false
    @Published var alertError: AlertError?
    @Published var showSettingAlert = false
    @Published var isPermissionGranted = false
    @Published var loading = false
    @Published var translatedText = "Wait for input..."
    
    var session: AVCaptureSession = .init()
    let ttsEngine: TTSEngine =  SwiftTTSCombine.Engine()

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
                requestCameraAccess()
            default:
                isPermissionGranted = false
                showAlertError = true
        }
    }
    
    private func requestCameraAccess() {
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
    }
    
    func switchCamera() {
        cameraManager.switchCamera()
    }
    
    func capturePhoto() {
        cameraManager.captureImage()
    }
    
    func startRecordingVideo() {
        cameraManager.startRecording()
        self.translatedText = "Recording..."
    }
    
    func stopRecordingVideo() {
        cameraManager.stopRecording()
        self.translatedText = "Processing..."
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.uploadVideo(url: self.cameraManager.videoOutputURL!)
        }
    }
    
    func uploadVideo(url: URL) {
        let uploadURL = "https://8000-01hreghjy50g0x9cqz22a22ssw.cloudspaces.litng.ai/predict"
        
        AF.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(url, withName: "video", fileName: "video.mp4", mimeType: "video/mp4")
            },
            to: uploadURL
        ).responseJSON { response in
            switch response.result {
            case .success(let data):
                if let jsonResponse = data as? [String: Any],
                   let result = jsonResponse["result"] as? String {
                    DispatchQueue.main.async {
                        self.translatedText = result
                        self.speak(text: result)
                    }
                }
            case .failure(let error):
                print("Error uploading video: \(error)")
                DispatchQueue.main.async {
                    self.translatedText = "Error uploading video"
                }
            }
            
            DispatchQueue.main.async {
                self.loading = false
            }
        }
        
        self.loading = true
    }
    
    private func handleResponse(response: Data) {
        do {
            if let jsonResponse = try JSONSerialization.jsonObject(with: response, options: []) as? [String: Any],
               let result = jsonResponse["result"] as? String {
                DispatchQueue.main.async {
                    self.translatedText = result
                    self.speak(text: result)
                }
            }
        } catch {
            print("Error decoding prediction: \(error)")
            DispatchQueue.main.async {
                self.translatedText = "Error decoding prediction"
            }
        }
    }
    
    private func createMultipartFormData(url: URL, boundary: String) -> Data {
        var data = Data()
                
        data.append("--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"video\"; filename=\"video.mp4\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: video/quicktime\r\n\r\n".data(using: .utf8)!)
        data.append(try! Data(contentsOf: url))
        data.append("\r\n".data(using: .utf8)!)
        data.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        return data
    }
    
    private func speak(text: String) {
        ttsEngine.speak(string: text)
    }
}
