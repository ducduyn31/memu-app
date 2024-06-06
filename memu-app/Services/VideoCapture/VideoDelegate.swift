//
//  VideoDelegate.swift
//  memu-app
//
//  Created by Duy Nguyen on 25/5/2024.
//

import AVFoundation
import UIKit

class VideoDelegate: NSObject, AVCaptureFileOutputRecordingDelegate {
    
    private let completion: (URL?, Error?) -> Void
    
    init(completion: @escaping (URL?, Error?) -> Void) {
        self.completion = completion
    }
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        if let error = error {
            print("Error recording video: \(error)")
        } else {
            print("Video recorded successfully")
            UISaveVideoAtPathToSavedPhotosAlbum(outputFileURL.path(), nil, nil, nil)
        }
    }
}
