//
//  ScannerViewModel.swift
//  IbanRecognizer
//
//  Created by HAMZA on 15/11/2024.
//

import AVFoundation
import Combine
import Vision
import UIKit

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
    private let operationQueue = OperationQueue()
    @Published  var recognizedIban: String?
    
    init() { }
        
    func handleCameraPreviews() async {
        for await image in cameraManager.previewStream {
            Task { @MainActor in
                currentFrame = image
                if let cropedFrame = cropedFrame {
                    
                    operationQueue.addOperation { [weak self] in
                        self?.recognizeImageWithTesseract(image: cropedFrame)
                    }
                }
            }
        }
    }
    
    func handleCameraPreviews() {
         Task {
            await handleCameraPreviews()
        }
    }
    
}

extension ScannerViewModel {
    
    func recognizeImageWithTesseract(image: CGImage) {
        let text = image.getRecognizedText(recognitionLevel: .accurate)
        print(text)
    }
}
