//
//  CameraManager.swift
//  IbanRecognizer
//
//  Created by HAMZA on 15/11/2024.
//

import Foundation
import AVFoundation

class CameraManager: NSObject {
    private let videoRotationAngle = 90.0
    var captureSessionQueue = DispatchQueue(label: "video.session.queue")
    var captureDeviceInput: AVCaptureDeviceInput?
    var captureVideoOutput: AVCaptureVideoDataOutput?
    var captureSession = AVCaptureSession()
    var systemPreferredCamera = AVCaptureDevice.default(for: .video)
    var addToPreviewStream: ((CGImage) -> Void)?
    
    override init() {
        super.init()
        configureSession()
    }
    
    lazy var previewStream: AsyncStream<CGImage> = {
        AsyncStream { continuation in
            addToPreviewStream = { cgImage in
                continuation.yield(cgImage)
            }
        }
    }()
    
    private func configureSession() {

        guard let systemPreferredCamera,
              let deviceInput = try? AVCaptureDeviceInput(device: systemPreferredCamera)
        else { return }
        if let range = systemPreferredCamera.activeFormat.videoSupportedFrameRateRanges.first {
            do { try systemPreferredCamera.lockForConfiguration()
                systemPreferredCamera.activeVideoMinFrameDuration = CMTimeMake(value: 1, timescale: Int32(range.minFrameRate))
                systemPreferredCamera.activeVideoMaxFrameDuration = CMTimeMake(value: 1, timescale: Int32(range.minFrameRate))
                systemPreferredCamera.unlockForConfiguration()
            } catch {
                print("LockForConfiguration failed with error: \(error.localizedDescription)")
            }
        }
        captureSession.beginConfiguration()
        
        defer {
            self.captureSession.commitConfiguration()
        }
        
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: captureSessionQueue)
        
        guard captureSession.canAddInput(deviceInput) else {
            print("Cannot add device input to capture session.")
            return
        }
        
        guard captureSession.canAddOutput(videoOutput) else {
            print("Cannot add video output to capture session.")
            return
        }
        
        captureSession.addInput(deviceInput)
        captureSession.addOutput(videoOutput)
        
    }
    
    func startSession() {
        Task {
            captureSession.startRunning()
        }
    }
    func stopSession() {
        Task {
            captureSession.stopRunning()
        }
    }
}

extension CameraManager: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput,
                       didOutput sampleBuffer: CMSampleBuffer,
                       from connection: AVCaptureConnection) {
        connection.videoRotationAngle = videoRotationAngle
        guard let currentFrame = sampleBuffer.toCGImage else { return }
        addToPreviewStream?(currentFrame)
    }
    
}
