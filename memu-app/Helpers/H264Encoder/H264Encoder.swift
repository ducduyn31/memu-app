//
//  H264Encoder.swift
//  memu-app
//
//  Created by JonathanSjamsudin on 9/5/2024.
//

import AVFoundation
import VideoToolbox

enum H264EncoderError: Error {
    case cannotCreateSession
    case cannotSetProperties
    case cannotPrepareToEncode
}

class H264Encoder: NSObject {
    
    private var _session: VTCompressionSession!
    
    private static let naluStartCode = Data([UInt8](arrayLiteral: 0x00, 0x00, 0x00, 0x01))
    var naluHandling: ((Data) -> Void)?
    
    override init() {
        super.init()
    }
}

extension H264Encoder: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    private var encodingOutputCallback: VTCompressionOutputCallback = { (outputCallbackRefCon: UnsafeMutableRawPointer?, _: UnsafeMutableRawPointer?, status: OSStatus, flags: VTEncodeInfoFlags, sampleBuffer: CMSampleBuffer?) in
        guard let sampleBuffer = sampleBuffer else {
            print("nil buffer")
            return
        }
        guard let refcon: UnsafeMutableRawPointer = outputCallbackRefCon else {
            print("nil pointer")
            return
        }
        guard status == noErr else {
            print("encoding failed")
            return
        }
        guard CMSampleBufferDataIsReady(sampleBuffer) else {
            print("CMSampleBuffer is not ready to use")
            return
        }
        guard flags != VTEncodeInfoFlags.frameDropped else {
            print("frame dropped")
            return
        }
        
        let encoder: H264Encoder = Unmanaged<H264Encoder>.fromOpaque(refcon).takeUnretainedValue()
        
        // if the encoded frame is key frame, we need to extract sps and pps data from it
        if sampleBuffer.isKeyFrame {
            encoder.extractSPSAndPPS(from: sampleBuffer)
        }
        
        // dataBuffer is wrapper for media data(here it is h264 format)
        guard let dataBuffer = sampleBuffer.dataBuffer else { return }
        
        var totalLength: Int = 0
        var dataPointer: UnsafeMutablePointer<Int8>?
        let error = CMBlockBufferGetDataPointer(dataBuffer,
                                                atOffset: 0,
                                                lengthAtOffsetOut: nil,
                                                totalLengthOut: &totalLength,
                                                dataPointerOut: &dataPointer)
        
        guard error == kCMBlockBufferNoErr,
              let dataPointer = dataPointer else { return }
        
        var packageStartIndex = 0
        
        // dataPointer has several NAL units which respectively is
        // composed of 4 bytes data represents NALU length and pure NAL unit.
        // To reduce confusion, i call it a package which represents (4 bytes NALU length + NAL Unit)
        while packageStartIndex < totalLength {
            var nextNALULength: UInt32 = 0
            memcpy(&nextNALULength, dataPointer.advanced(by: packageStartIndex), 4)
            // First four bytes of package represents NAL unit's length in Big Endian.
            // We should convert Big Endian Representation to Little Endian becasue
            // nextNALULength variable here should be representation of human readable number.
            nextNALULength = CFSwapInt32BigToHost(nextNALULength)
            
            var nalu = Data(bytes: dataPointer.advanced(by: packageStartIndex+4),
                            count: Int(nextNALULength))
            
            packageStartIndex += (4 + Int(nextNALULength))
            
            encoder.naluHandling?(H264Encoder.naluStartCode + nalu)
        }
    }

    
    func captureOutput(_ output: AVCaptureOutput,
                       didOutput sampleBuffer: CMSampleBuffer,
                       from connection: AVCaptureConnection) {
        
        encode(buffer: sampleBuffer)
    }
    
    private func encode(buffer: CMSampleBuffer) {
        guard let session = _session,
              let px = CMSampleBufferGetImageBuffer(buffer) else { return }
        let timeStamp = CMSampleBufferGetPresentationTimeStamp(buffer)
        let duration = CMSampleBufferGetDuration(buffer)
        
        VTCompressionSessionEncodeFrame(session,
                                        imageBuffer: px,
                                        presentationTimeStamp: timeStamp,
                                        duration: duration,
                                        frameProperties: nil,
                                        sourceFrameRefcon: nil,
                                        infoFlagsOut: nil)
    }
    
    func configureCompressSession() throws {
        let error = VTCompressionSessionCreate(allocator: kCFAllocatorDefault,
                                             width: Int32(720),
                                             height: Int32(1280),
                                             codecType: kCMVideoCodecType_H264,
                                             encoderSpecification: nil,
                                             imageBufferAttributes: nil,
                                             compressedDataAllocator: kCFAllocatorDefault,
                                             outputCallback: encodingOutputCallback,
                                             refcon: Unmanaged.passUnretained(self).toOpaque(),
                                             compressionSessionOut: &_session)
        
        guard error == errSecSuccess,
              let session = _session else {
            throw ConfigurationError.cannotCreateSession
        }
        
        let propertyDictionary = [
            kVTCompressionPropertyKey_ProfileLevel: kVTProfileLevel_H264_Baseline_AutoLevel,
            kVTCompressionPropertyKey_MaxKeyFrameInterval: 60,
            kVTCompressionPropertyKey_RealTime: true,
            kVTCompressionPropertyKey_Quality: 0.5,
        ] as CFDictionary
        
        guard VTSessionSetProperties(session, propertyDictionary: propertyDictionary) == noErr else {
            throw ConfigurationError.cannotSetProperties
        }
        
        guard VTCompressionSessionPrepareToEncodeFrames(session) == noErr else {
            throw ConfigurationError.cannotPrepareToEncode
        }
        
        print("VTCompressSession is ready to use")
    }
}

extension CMSampleBuffer {
    var isKeyFrame: Bool {
        let attachments =  CMSampleBufferGetSampleAttachmentsArray(self, createIfNecessary: true) as? [[CFString: Any]]
        
        let isNotKeyFrame = (attachments?.first?[kCMSampleAttachmentKey_NotSync] as? Bool) ?? false
        
        return !isNotKeyFrame
    }
    
    private func extractSPSAndPPS(from sampleBuffer: CMSampleBuffer) {
        guard let description = CMSampleBufferGetFormatDescription(sampleBuffer) else { return }
        
        var parameterSetCount = 0
        CMVideoFormatDescriptionGetH264ParameterSetAtIndex(description,
                                                           parameterSetIndex: 0,
                                                           parameterSetPointerOut: nil,
                                                           parameterSetSizeOut: nil,
                                                           parameterSetCountOut: &parameterSetCount,
                                                           nalUnitHeaderLengthOut: nil)
        guard parameterSetCount == 2 else { return }
        
        var spsSize: Int = 0
        var sps: UnsafePointer<UInt8>?
        
        // get sps data and it's size
        CMVideoFormatDescriptionGetH264ParameterSetAtIndex(description,
                                                           parameterSetIndex: 0,
                                                           parameterSetPointerOut: &sps,
                                                           parameterSetSizeOut: &spsSize,
                                                           parameterSetCountOut: nil,
                                                           nalUnitHeaderLengthOut: nil)
        
        var ppsSize: Int = 0
        var pps: UnsafePointer<UInt8>?
        
        // get pps data and it's size
        CMVideoFormatDescriptionGetH264ParameterSetAtIndex(description,
                                                           parameterSetIndex: 1,
                                                           parameterSetPointerOut: &pps,
                                                           parameterSetSizeOut: &ppsSize,
                                                           parameterSetCountOut: nil,
                                                           nalUnitHeaderLengthOut: nil)
        guard let sps = sps,
              let pps = pps else { return }
        
        [Data(bytes: sps, count: spsSize), Data(bytes: pps, count: ppsSize)].forEach {
            naluHandling?(H264Encoder.naluStartCode + $0)
        }
    }
    view raw
}
    

