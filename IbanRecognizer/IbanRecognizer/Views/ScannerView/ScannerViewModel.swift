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
            subscription = cropedFrame.publisher.sink(receiveValue: { [weak self] image in
                self?.operationQueue.addOperation { [weak self] in
                    let recognizedTexts = self?.recognizedTexts(image: image)
                    if let recognizedTexts = recognizedTexts {
                        Task { @MainActor [weak self] in
                            self?.recognizedIban = self?.recognizedIBAN(texts: recognizedTexts)
                        }
                    }
                }
            })
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
    
    func resetIban() {
        recognizedIban = nil
        validatedIban = ""
    }
    
}

extension ScannerViewModel {
    
    func recognizedTexts(image: CGImage) -> [String] {
        let recognizedTexts = image.recognizedTexts(recognitionLevel: .accurate)
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

