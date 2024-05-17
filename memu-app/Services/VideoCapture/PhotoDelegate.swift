//
//  CameraDelegate.swift
//  memu-app
//
//  Created by Duy Nguyen on 13/5/2024.
//

import AVFoundation
import UIKit

struct PhotoCaptureCallbackArguments {
    let image: UIImage?
    let data: Data?
}

class PhotoDelegate: NSObject, AVCapturePhotoCaptureDelegate {
    
    private let completion: (PhotoCaptureCallbackArguments?) -> Void
    
    init(completion: @escaping (PhotoCaptureCallbackArguments?) -> Void) {
          self.completion = completion
       }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            print("Error capturing photo: \(error)")
            completion(nil)
            return
        }
        
        guard let imageData = photo.fileDataRepresentation() else {
            print("Error converting photo to data")
            completion(nil)
            return
        }
        
        guard let image = UIImage(data: imageData) else {
            print("Error converting data to image")
            completion(nil)
            return
        }
        
        completion(PhotoCaptureCallbackArguments(image: image, data: imageData))
    }
}

