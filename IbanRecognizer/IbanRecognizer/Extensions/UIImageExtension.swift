//
//  UIImageExtension.swift
//  IbanRecognizer
//
//  Created by HAMZA on 16/11/2024.
//

import UIKit
import Vision

extension CGImage {
    
    func getRecognizedText(recognitionLevel: VNRequestTextRecognitionLevel,
                           minimumTextHeight: Float = 0.03125) -> [String] {
        var recognizedTexts = [String]()
        
        let requestHandler = VNImageRequestHandler(cgImage: self, options: [:])

        let request = VNRecognizeTextRequest { (request, error) in
            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
            let recognizedStrings = observations.compactMap { observation in
                    // Return the string of the top VNRecognizedText instance.
                    return observation.topCandidates(1).first?.string
                }
            recognizedTexts.append(contentsOf: recognizedStrings)
        }

        request.recognitionLevel = recognitionLevel
        request.minimumTextHeight = minimumTextHeight

        request.usesLanguageCorrection = false
        
        try? requestHandler.perform([request])
                            
        return recognizedTexts
    }

}
