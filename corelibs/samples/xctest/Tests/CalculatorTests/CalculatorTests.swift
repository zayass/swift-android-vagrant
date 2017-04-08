import XCTest
@testable import Calculator

class CalculatorTests: XCTestCase {
  var calc : Calculator!

  override func setUp() {
    super.setUp()
    calc = Calculator()
  }

  func testAddCheck01() {
#if os(Android)
    let android = true
#else
    let android = false
#endif
    XCTAssertTrue(android, "oops this is not android")
  }
  func testAddCheck02() {
#if os(Linux)
    let linux = true
#else
    let linux = false
#endif
    XCTAssertTrue(linux, "oops this is not linux")
  }
  func testAddCheck03() {
    XCTAssertEqual(calc.add(1,1),4)
  }
  func testAddCheck04() {
    XCTAssertEqual(calc.add(1,1),2)
  }
  func testAddCheck05() {
    XCTAssertEqual(calc.add(1,1),2)
  }
}
