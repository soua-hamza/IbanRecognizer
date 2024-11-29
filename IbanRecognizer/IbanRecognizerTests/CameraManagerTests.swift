//
//  CameraManagerTests.swift
//  IbanRecognizerTests
//
//  Created by HAMZA on 18/11/2024.
//

import AVFoundation
@testable import IbanRecognizer
import XCTest

final class CameraManagerTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        try super.tearDownWithError()
    }

    // MARK: - Test Initialization

    func test_CameraManager_initialization_succeed() {
        //        WHEN
        //  sut: system under test
        let sut: CameraManager
        //        GIVEN
        sut = CameraManager()
        //        THEN
        XCTAssertNotNil(sut, "CameraManager should not be nil after initialization.")
    }

    // MARK: - Test Configuration

    func test_configureSession_succeed() {
        //        WHEN
        //  sut: system under test
        let sut: CameraManager
        //        GIVEN
        // configuration is set in the intialization
        sut = CameraManager()
        //        THEN
        XCTAssertNotNil(sut.captureSession.inputs, "Capture session inputs should be configured.")
        XCTAssertNotNil(sut.captureSession.outputs, "Capture session outputs should be configured.")
    }

    // MARK: - Test Session Start

    func test_frames_captured() {
        //  WHEN
        //  sut: system under test
        let sut: CameraManager
        var frameCaptured = false
        let frameCapturedExpectation = expectation(description: "Frame was captured")

        //  GIVEN
        sut = CameraManager() // configuration are made in the intialization
        sut.startSession()
        //  THEN
        sut.addToPreviewStream = { _ in
            if !frameCaptured {
                frameCaptured = true
                frameCapturedExpectation.fulfill()
            }
        }

        // Wait for the frame capture
        waitForExpectations(timeout: 20) // Adjust timeout as needed for testing

        // After waiting, check if the capture session is running
        // WORK ONLY ON DEVICE
        XCTAssertTrue(frameCaptured, "frame should be captured after startSession() is called")
        XCTAssertTrue(sut.captureSession.isRunning, "The capture session should be running after startSession() is called")
    }

    // MARK: - Test Video Output Handling

    func test_capture_output_delegate_isCalled() {
        //  WHEN
        //  sut: system under test
        class CameraManagerMock: CameraManager {
            var captureOutputDelegateIsCalled = false
            var captureOutputClosure: (() -> Void)?
            override func captureOutput(_: AVCaptureOutput, didOutput _: CMSampleBuffer, from _: AVCaptureConnection) {
                captureOutputDelegateIsCalled = true
                captureOutputClosure?()
            }
        }

        let sut: CameraManagerMock
        let expectation = self.expectation(description: "capture output delegate isCalled")

        //  GIVEN
        sut = CameraManagerMock() // configuration are made in the intialization
        sut.startSession()

        //  THEN

        sut.captureOutputClosure = {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 20)
        // WORK ONLY ON DEVICE
        XCTAssertTrue(sut.captureOutputDelegateIsCalled, "capture output delegate isCalled after startSession() is called.")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
