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
    private let ibanValidatorManager: IBANValidator
    private let textRecognitionHandler: TextRecognitionManager
    
    @Published var currentFrame: CGImage?
    @Published var cropedFrame: CGImage? {
        didSet {
            processCroppedFrame(cropedFrame)
        }
    }
    private let operationQueue = OperationQueue()
    @Published  var recognizedIban: String? {
        didSet {
            if recognizedIban != nil {
                operationQueue.cancelAllOperations()
            }
        }
    }
    
    @Published  var validatedIban: String = ""
    
    init() {
        ibanValidatorManager = IBANValidatorManager()
        textRecognitionHandler = TextRecognitionManager(recognitionLevel: .accurate)

    }
    
    
    func handleCameraPreviews() async {
        for await image in cameraManager.previewStream {
            Task { @MainActor in
                currentFrame = image
            }
        }
    }
    
    func handleCameraPreviews() {
        cameraManager.startSession()
         Task {
            await handleCameraPreviews()
        }
    }
    
    func stopCameraPreviews() {
        cameraManager.stopSession()
    }
    
}

extension ScannerViewModel {
    private func processCroppedFrame(_ cropedFrame: CGImage?) {
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

extension ScannerViewModel {
    
    func recognizedTexts(image: CGImage) -> [String] {
        frameCounter += 1
        guard frameCounter % 10 == 0 else {
            return ["skip"]
        } // Process every 10th frame

        let recognizedTexts = textRecognitionHandler.recognizeText(in: image)
        print(recognizedTexts)
        return recognizedTexts
    }
}

extension ScannerViewModel {
    func recognizedIBAN(texts: [String]) -> String? {
        texts.first { ibanValidatorManager.validate(iban: $0) }
    }
    
    func resetIban() {
        recognizedIban = nil
        validatedIban = ""
    }
}






