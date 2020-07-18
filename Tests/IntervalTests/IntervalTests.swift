import XCTest
@testable import Interval

final class IntervalTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Interval().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
