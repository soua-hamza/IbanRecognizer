//
//  ScannerViewTests.swift
//  IbanRecognizerTests
//
//  Created by HAMZA on 19/11/2024.
//

@testable import IbanRecognizer
import XCTest

final class ScannerViewTests: XCTestCase {
    var scannerView: ScannerView!
    var scannerViewModelMock: ScannerViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        scannerViewModelMock = ScannerViewModel()
        scannerView = ScannerView()
        _ = scannerView.environmentObject(scannerViewModelMock)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        scannerView = nil
        scannerViewModelMock = nil
    }

    func test_cropImage_should_return_correct_croppedImage() {
        // Given
        let originalImage = UIImage(resource: .ibanScreen)

        // When
        let croppedImage = scannerView.cropImage(inputImage: originalImage)

        // Then
        XCTAssertNotNil(croppedImage)
    }

    func test_cropImage_should_return_Nil_for_invalidImage() {
        // Given:
        let invalidImage = UIImage() // Empty image

        // When:
        let croppedImage = scannerView.cropImage(inputImage: invalidImage)

        // Then:
        XCTAssertNil(croppedImage)
    }

    func test_cropImage_correct_cropping_zone() {
        // Given:
        let originalImage = UIImage(resource: .screen)
        let imageViewScale = max(originalImage.size.width / UIScreen.main.bounds.width,
                                 originalImage.size.height / UIScreen.main.bounds.height)
        let expectedCropZone = CGRect(x: 0, y: 0, width: (UIScreen.main.bounds.width - 50) * imageViewScale, height: 60 * imageViewScale)

        // When:
        if let croppedImage = scannerView.cropImage(inputImage: originalImage) {
            let actualRect = CGRect(x: 0, y: 0, width: croppedImage.width, height: croppedImage.height)

            // Then:
            // SCREEN SHOT MADE WITH IPHONE SE, TEST WORK ONLY ON IPHONE SE
            XCTAssertEqual(expectedCropZone, actualRect)
        } else {
            XCTFail("Cropped image is nil")
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
