//
//  CalculatorTests.swift
//

import XCTest
@testable import UnitTesting

final class CalculatorTests: XCTestCase {
    var calculator: Calculator!

    override func setUp() {
        super.setUp()
        calculator = Calculator()
    }
    
    override func tearDown() {
        calculator = nil
        super.tearDown()
    }

    // Given two numbers, when multiplying, then the result is their product
    func test_multiplication() {
        let result = calculator.multiply(10, 20)
        XCTAssertEqual(200, result)
    }
    
    // Given a non-zero divisor, when dividing, then the result is the quotient
    func test_divideByNonZero() throws {
        let firstCase = try calculator.divide(5, 1)
        
        XCTAssertEqual(firstCase, 5)
        
        let secondCase = try calculator.divide(4500, 12)
        
        XCTAssertEqual(secondCase, 375)
        
        let thirdCase = try calculator.divide(1, 4)
        
        XCTAssertEqual(thirdCase, 0)
    }

    // Given a zero divisor, when dividing, then it throws a .divisionByZero error
    // use XCTAssertThrowsError, XCTAssertEqual
    func test_divideByZero_throwsError() {
        XCTAssertThrowsError(try calculator.divide(0, 0)) { err in
            XCTAssertEqual(err as? Calculator.CalculatorError, Calculator.CalculatorError.divisionByZero)
        }
    }

    // Check 3 scenarios: < 10, 10, > 10
    // use XCTAssertTrue, XCTAssertFalse
    func test_isGreaterThanTen() {
        let firstCase = calculator.isGreaterThanTen(4)
        XCTAssertFalse(firstCase, "Expected shoud be false and got: \(firstCase)")
        
        let secondCase = calculator.isGreaterThanTen(10)
        XCTAssertFalse(secondCase, "Expected shoud be false and got: \(secondCase)")
        
        let thirdCase = calculator.isGreaterThanTen(11)
        XCTAssertTrue(thirdCase, "Expected shoud be false and got: \(thirdCase)")
    }

    // Use XCTAssertNotNil and/or XCTAssertEqual
    func test_safeSquareRoot_whenPositiveNumber_returnsValue() {
        let firstCase = calculator.safeSquareRoot(4)
        XCTAssertNotNil(firstCase)
        XCTAssertEqual(firstCase, 2.0)
        
        let secondCase = calculator.safeSquareRoot(121)
        XCTAssertNotNil(secondCase)
        XCTAssertEqual(secondCase, 11)
        
        let thridCase = calculator.safeSquareRoot(34)
        XCTAssertNotNil(thridCase)
    
        let thridCaseResult = String(format: "%.2f", thridCase!)
        XCTAssertEqual("5.83", thridCaseResult)
        
        let fourthCase = calculator.safeSquareRoot(0)
        XCTAssertNotNil(fourthCase)
        XCTAssertEqual(fourthCase, 0)
        
    }

    // Use XCTAssertNil
    func test_safeSquareRoot_whenNegativeNumber_returnsNil() {
        let firstCase = calculator.safeSquareRoot(-4)
        XCTAssertNil(firstCase)
        
        let secondCase = calculator.safeSquareRoot(-121)
        XCTAssertNil(secondCase)
    }
}
