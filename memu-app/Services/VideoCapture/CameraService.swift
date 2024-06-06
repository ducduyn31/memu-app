//
//  CameraService.swift
//  memu-app
//
//  Created by Duy Nguyen on 13/5/2024.
//

import AVFoundation

/// A service to manage camera configuration and capture session
/// It is responsible for setting up camera input and output
/// and managing the capture session
class CameraService : ObservableObject {
    
    enum Status {
        case notAuthorized
        case notConfigured
        case failed
        case success
    }
    
    @Published var status: Status = .notConfigured
    
    let captureSession = AVCaptureSession()
    private let photoOutput = AVCapturePhotoOutput()
    private var videoDeviceInput: AVCaptureDeviceInput?
    private var videoOutput: AVCaptureMovieFileOutput?
    private var position = AVCaptureDevice.Position.back
    
    private let sessionQueue = DispatchQueue(label: "mimuai.session.queue")
    private var photoDelegate: PhotoDelegate?
    private var videoDelegate: VideoDelegate?
    var videoOutputURL: URL?
    
    func configureSession() {
        sessionQueue.async { [weak self] in
            guard let self, self.status == .notConfigured else { return }
            
            self.captureSession.beginConfiguration()
            self.captureSession.sessionPreset = .photo
            
            self.setupVideoInput()
            self.setupPhotoOutput()
            self.setupVideoOutput()
            
            self.captureSession.commitConfiguration()
            
            self.startCaptureSession()
        }
    }
    
    private func setupVideoInput() {
        do {
            let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: position)
            
            guard videoDevice != nil else {
                status = .notConfigured
                captureSession.commitConfiguration()
                return
            }
            
            videoDeviceInput = try AVCaptureDeviceInput(device: videoDevice!)
            
            if captureSession.canAddInput(videoDeviceInput!) {
                captureSession.addInput(videoDeviceInput!)
                status = .success
            } else {
                status = .notConfigured
                captureSession.commitConfiguration()
            }
        } catch {
            print("Error setting up video input: \(error.localizedDescription)")
            status = .failed
            captureSession.commitConfiguration()
        }
    }
    
    private func setupPhotoOutput() {
        if captureSession.canAddOutput(photoOutput) {
            captureSession.addOutput(photoOutput)
            
            photoOutput.maxPhotoQualityPrioritization = .quality
            
            status = .success
        } else {
            status = .failed
            captureSession.commitConfiguration()
        }
    }
    
    private func setupVideoOutput() {
        videoOutput = AVCaptureMovieFileOutput()
                
        if captureSession.canAddOutput(videoOutput!) {
            captureSession.addOutput(videoOutput!)
        } else {
            status = .failed
            captureSession.commitConfiguration()
        }
    }
    
    private func startCaptureSession() {
        if status == .success && !captureSession.isRunning {
            captureSession.startRunning()
        } else if status != .failed {
            print("Capture session is not running.")
        }
    }
    
    func stopCaptureSession() {
        sessionQueue.async { [weak self] in
            guard let self else { return }
            
            if self.captureSession.isRunning {
                self.captureSession.stopRunning()
            }
        }
    }
    
    /// Switch between front and back camera
    func switchCamera() {
        sessionQueue.async { [weak self] in
            guard let self, self.videoDeviceInput != nil else { return }
            
            self.captureSession.beginConfiguration()
            
            self.captureSession.removeInput(self.videoDeviceInput!)
            
            self.position = self.position == .back ? .front : .back
            self.setupVideoInput()
            
            self.captureSession.commitConfiguration()
        }
    }
    
    /// Capture an image using the current camera configuration
    func captureImage() {
        sessionQueue.async { [weak self] in
            guard let self else { return }
            
            var settings = AVCapturePhotoSettings()
            
            if photoOutput.availablePhotoCodecTypes.contains(.hevc) {
                settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.hevc])
            }
            
            settings.maxPhotoDimensions = .init(width: 4032, height: 3024)
            settings.photoQualityPrioritization = .quality
            
            photoDelegate = PhotoDelegate { result in
                print("Image captured")
            }
            
            if let photoDelegate {
                self.photoOutput.capturePhoto(with: settings, delegate: photoDelegate)
            }
            
        }
    }
    
    func startRecording() {
        sessionQueue.async { [weak self] in
            guard let self, let videoOutput = self.videoOutput else { return }
            
            if !videoOutput.isRecording {
                let outputFileName = UUID().uuidString
                let outputFilePath = NSTemporaryDirectory() + outputFileName + ".mov"
                let fileURL = URL(fileURLWithPath: outputFilePath)
                
                videoDelegate = VideoDelegate { result, error in
                    if let resultURL = result {
                        self.convertMovToMp4(sourceURL: resultURL) { outputURL in
                            if let outputURL {
                                self.videoOutputURL = outputURL
                            }
                        }
                    }
                }
                
                if let videoDelegate {
                    self.videoOutputURL = fileURL
                    videoOutput.startRecording(to: fileURL, recordingDelegate: videoDelegate)
                }
            }
        }
    }
    
    func stopRecording() {
        sessionQueue.async { [weak self] in
            guard let self, let videoOutput = self.videoOutput else { return }
            
            if videoOutput.isRecording {
                videoOutput.stopRecording()
            }
        }
    }
    
    private func convertMovToMp4(sourceURL: URL, completion: @escaping (URL?) -> Void) {
        let asset = AVAsset(url: sourceURL)
        let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetHighestQuality)
        
        let outputFileName = UUID().uuidString
        let outputFilePath = NSTemporaryDirectory() + outputFileName + ".mp4"
        let outputURL = URL(fileURLWithPath: outputFilePath)
        
        exportSession?.outputURL = outputURL
        exportSession?.outputFileType = .mp4
        exportSession?.exportAsynchronously {
            switch exportSession?.status {
            case .completed:
                print("Export completed successfully.")
                completion(outputURL)
            case .failed:
                if let error = exportSession?.error {
                    print("Export failed: \(error.localizedDescription)")
                }
                completion(nil)
            case .cancelled:
                print("Export cancelled.")
                completion(nil)
            default:
                print("Export encountered an unknown status.")
                completion(nil)
            }
        }
    }
    
}
