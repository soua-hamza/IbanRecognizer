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
    private var captureSessionQueue = DispatchQueue(label: "video.session.queue")
    private var captureDeviceInput: AVCaptureDeviceInput?
    private var captureVideoOutput: AVCaptureVideoDataOutput?
    private let captureSession = AVCaptureSession()
    private let systemPreferredCamera = AVCaptureDevice.default(for: .video)
    private var addToPreviewStream: ((CGImage) -> Void)?

    override init() {
        super.init()
        Task {
            await configureSession()
            await startSession()
        }
    }
    
    lazy var previewStream: AsyncStream<CGImage> = {
        AsyncStream { continuation in
            addToPreviewStream = { cgImage in
                continuation.yield(cgImage)
            }
        }
    }()
    
    private func configureSession() async {

        guard let systemPreferredCamera,
              let deviceInput = try? AVCaptureDeviceInput(device: systemPreferredCamera)
        else { return }
        
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
    
    private func startSession() async {
        captureSession.startRunning()
    }
}

extension CameraManager: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput,
                       didOutput sampleBuffer: CMSampleBuffer,
                       from connection: AVCaptureConnection) {
        connection.videoRotationAngle = videoRotationAngle
        guard let currentFrame = sampleBuffer.cgImage else { return }
        addToPreviewStream?(currentFrame)
    }
    
}
