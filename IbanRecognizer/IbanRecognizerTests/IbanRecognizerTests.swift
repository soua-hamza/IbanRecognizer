//
//  IbanRecognizerTests.swift
//  IbanRecognizerTests
//
//  Created by soua hamza on 13/11/2024.
//

@testable import IbanRecognizer
import XCTest

final class IbanRecognizerTests: XCTestCase {
    var ibanValidator = IBANValidatorManager()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_Iban_regex_succeed() throws {
        // WHEN
        let sut = String("FR1420010101150500013M02606")
        // GIVEN
        let result = ibanValidator.validate(iban: sut)
        // THEN
        XCTAssertTrue(result)
    }

    func test_Iban_regex_fail() throws {
        // WHEN
        let sut = String("FR14K0010101150500013M02606")
        // GIVEN
        let result = ibanValidator.validate(iban: sut)
        // THEN
        XCTAssertFalse(result)
    }

    func test_trim_Iban_regex_succeed() throws {
        // WHEN
        let sut = String("FR76 3000 3035 9000 0507 0680 463")
        // GIVEN
        let result = sut.trim().isValidIban()
        // THEN
        XCTAssertTrue(result)
    }

    func test_trim_Iban_regex_fail() throws {
        // WHEN
        let sut = String("FR14 K001 0101 1505 0001 3M02 606")
        // GIVEN
        let result = sut.trim().isValidIban()
        // THEN
        XCTAssertFalse(result)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
