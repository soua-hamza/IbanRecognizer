//
//  IbanRecognizerTests.swift
//  IbanRecognizerTests
//
//  Created by soua hamza on 13/11/2024.
//

import XCTest
@testable import IbanRecognizer

final class IbanRecognizerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_Iban_regex_succeed() throws {
        //WHEN
        let sut = String("FR1420010101150500013M02606")
        //GIVEN
        let result = sut.isValidIban()
        //THEN
        XCTAssertTrue(result)
    }

    func test_Iban_regex_fail() throws {
        //WHEN
        let sut = String("FR14K0010101150500013M02606")
        //GIVEN
        let result = sut.isValidIban()
        //THEN
        XCTAssertFalse(result)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
