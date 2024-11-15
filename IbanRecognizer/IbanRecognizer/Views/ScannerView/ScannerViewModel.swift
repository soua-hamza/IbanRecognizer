//
//  ScannerViewModel.swift
//  IbanRecognizer
//
//  Created by HAMZA on 15/11/2024.
//

import AVFoundation
import Combine

class ScannerViewModel: ObservableObject {
    
    private lazy var cameraManager = CameraManager()
    @Published var currentFrame: CGImage?
    private var subscription: AnyCancellable?
    @Published var cropedFrame: CGImage? {
        didSet {
            subscription = cropedFrame.publisher.sink(receiveValue: { image in
                
            })
        }
    }
    
    init() { }
        
    func handleCameraPreviews() async {
        for await image in cameraManager.previewStream {
            Task { @MainActor in
                currentFrame = image
            }
        }
    }
    
    func handleCameraPreviews() {
         Task {
            await handleCameraPreviews()
        }
    }
}
