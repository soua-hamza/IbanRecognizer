//
//  ScannerViewModelTests.swift
//  IbanRecognizerTests
//
//  Created by HAMZA on 19/11/2024.
//

import XCTest
@testable import IbanRecognizer

final class ScannerViewModelTests: XCTestCase {
    var scannerViewModel: ScannerViewModel!
    var scannerView: ScannerView!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        scannerViewModel = ScannerViewModel()
        _ = ScannerView().environmentObject(scannerViewModel)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        scannerViewModel = nil
        scannerView = nil
    }
    
    func test_onFrameUpdate_should_update_currentFrame() {
        // Given: A mock CGImage to simulate a camera frame
        let mockImage = UIImage(resource: .ibanScreen).cgImage!
        
        // When: The camera frame updates
        scannerViewModel.currentFrame = mockImage
        
        // Then: Verify that the currentFrame property of the ScannerView is updated
        XCTAssertEqual(scannerViewModel.currentFrame, mockImage)
    }
    
    func test_on_recognized_iban_should_present_IBANSheet() {
        // Given: A mock IBAN that should trigger the IBAN sheet to be presented
        scannerViewModel.recognizedIban = "FR1420010101150500013M02606"
        
        // When: The recognizedIban changes
        _ = scannerView.onChange(of: scannerViewModel.recognizedIban, { oldValue, newValue in
            // Simulate that the IBAN sheet is presented when recognizedIban is set
            XCTAssertNotNil(newValue)
            XCTAssertEqual(newValue, "FR1420010101150500013M02606")
        })
    }
        
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

