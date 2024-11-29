//
//  TextRecognitionManagerTests.swift
//  IbanRecognizer
//
//  Created by Hamza on 28/11/2024.
//

@testable import IbanRecognizer
import XCTest

class TextRecognitionManagerTests: XCTestCase {
    func testTextRecognition() {
        let mockTextRecognition = TextRecognitionManager(recognitionLevel: .accurate)
        let mockImage = UIImage(named: "iban_screen")!.cgImage!
        let result = mockTextRecognition.recognizeText(in: mockImage)
        XCTAssertEqual(result, ["FR14 2001 0101 1505 0001 3M02 606"])
    }
}
