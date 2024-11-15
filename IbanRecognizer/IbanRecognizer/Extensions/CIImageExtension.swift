//
//  CIImageExtension.swift
//  IbanRecognizer
//
//  Created by HAMZA on 15/11/2024.
//

import Foundation
import CoreImage

extension CIImage {
    
    var cgImage: CGImage? {
        let ciContext = CIContext()
        
        guard let cgImage = ciContext.createCGImage(self, from: self.extent) else {
            return nil
        }
        
        return cgImage
    }
    
}
