import XCTest
@testable import CalculatorTests

extension CalculatorTests {
    static var allTests : [(String, (CalculatorTests) -> () throws -> Void)] {
        return [
            ("testAddCheck01", testAddCheck01),
            ("testAddCheck02", testAddCheck02),
            ("testAddCheck03", testAddCheck03),
            ("testAddCheck04", testAddCheck04),
            ("testAddCheck05", testAddCheck05)
        ]
    }
}

XCTMain([
    testCase(CalculatorTests.allTests)
])
