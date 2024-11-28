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
    private var frameCounter = 0
    private lazy var cameraManager = CameraManager()
    @Published var currentFrame: CGImage?
    @Published var cropedFrame: CGImage? {
        didSet {
            guard let image = cropedFrame else {return}
            self.operationQueue.addOperation { [weak self] in
                let recognizedTexts = self?.recognizedTexts(image: image)
                if let recognizedTexts = recognizedTexts {
                    Task { @MainActor [weak self] in
                        self?.recognizedIban = self?.recognizedIBAN(texts: recognizedTexts)
                    }
                }
            }
        }
    }
    private let operationQueue = OperationQueue()
    private let textRecognitionHandler = TextRecognitionManager(recognitionLevel: .accurate)
    @Published  var recognizedIban: String? {
        didSet {
            if recognizedIban != nil {
                operationQueue.cancelAllOperations()
            }
        }
    }
    
    @Published  var validatedIban: String = ""
    
    init() {
        
    }
    
    
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
    
    func stopCameraPreviews() {
        cameraManager.stopSession()
    }
    
    func resetIban() {
        recognizedIban = nil
        validatedIban = ""
    }
    
}

extension ScannerViewModel {
    
    func recognizedTexts(image: CGImage) -> [String] {
        frameCounter += 1
        guard frameCounter % 10 == 0 else {
            return ["skip"]
        } // Process every 10th frame

        let recognizedTexts = //image.recognizedTexts(recognitionLevel: .accurate)
        textRecognitionHandler.recognizeText(in: image)
        print(recognizedTexts)
        return recognizedTexts
    }
}
extension ScannerViewModel {
    func recognizedIBAN(texts: [String]) -> String? {
        texts.filter {
            $0.trim().isValidIban()
        }.first ?? nil
    }
    
}




