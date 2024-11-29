//
//  CIImageExtension.swift
//  IbanRecognizer
//
//  Created by HAMZA on 15/11/2024.
//

import CoreImage
import Foundation

extension CIImage {
    var toCGImage: CGImage? {
        let ciContext = CIContext()

        guard let cgImage = ciContext.createCGImage(self, from: extent) else {
            return nil
        }

        return cgImage
    }
}
