//
//  CMSampleBufferExtension.swift
//  IbanRecognizer
//
//  Created by HAMZA on 15/11/2024.
//

import AVFoundation
import CoreImage

extension CMSampleBuffer {
    
    var toCGImage: CGImage? {
        let pixelBuffer: CVPixelBuffer? = CMSampleBufferGetImageBuffer(self)
        
        guard let imagePixelBuffer = pixelBuffer else {
            return nil
        }
        
        return CIImage(cvPixelBuffer: imagePixelBuffer).toCGImage
    }
    
}
