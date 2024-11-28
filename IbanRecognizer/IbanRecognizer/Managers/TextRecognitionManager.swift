//
//  TextRecognitionManager.swift
//  IbanRecognizer
//
//  Created by Hamza on 28/11/2024.
//

import Vision

class TextRecognitionManager {
    private lazy var textRecognitionRequest: VNRecognizeTextRequest = {
        let request = VNRecognizeTextRequest { [weak self] request, error in
            self?.handleRecognitionResults(request: request, error: error)
        }
        request.recognitionLevel = .accurate
        request.usesLanguageCorrection = true
        return request
    }()

    private let requestHandler: VNSequenceRequestHandler // Reusable request handler for multiple frames

    private var recognizedTexts: [String] = []
    
    init(recognitionLevel: VNRequestTextRecognitionLevel) {
        requestHandler = VNSequenceRequestHandler()
    }
    
    private func handleRecognitionResults(request: VNRequest, error: Error?) {
            guard let results = request.results as? [VNRecognizedTextObservation] else {
                print("No results or error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            let topCandidates = results.compactMap { observation in
                observation.topCandidates(1).first?.string
            }

        print("Recognized texts: \(recognizedTexts)")
        recognizedTexts.append(contentsOf: topCandidates)
    }
    
    func recognizeText(in cgImage: CGImage) -> [String] {

        recognizedTexts.removeAll()
        
        do {
            try requestHandler.perform([textRecognitionRequest], on: cgImage)
        } catch {
            print("Error performing text recognition: \(error)")
        }
        
        return recognizedTexts
    }
    
}
