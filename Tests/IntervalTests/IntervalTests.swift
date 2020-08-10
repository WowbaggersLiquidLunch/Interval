import XCTest
@testable import Interval

final class IntervalTests: XCTestCase {
	
	///	Checks that interval operators work as intended.
    func testIntervalOperators() {
		
		//	MARK: Ascending Interval operators.
		
        let leftClosed0RightClosed1Interval = 0≤∙≤1
		XCTAssertTrue(leftClosed0RightClosed1Interval.isLowerBounded)
		XCTAssertTrue(leftClosed0RightClosed1Interval.isUpperBounded)
		XCTAssertTrue(leftClosed0RightClosed1Interval.isLowerClosed)
		XCTAssertTrue(leftClosed0RightClosed1Interval.isUpperClosed)
		
		let leftClosed0RightOpen1Interval = 0≤∙<1
		XCTAssertTrue(leftClosed0RightOpen1Interval.isLowerBounded)
		XCTAssertTrue(leftClosed0RightOpen1Interval.isUpperBounded)
		XCTAssertTrue(leftClosed0RightOpen1Interval.isLowerClosed)
		XCTAssertTrue(leftClosed0RightOpen1Interval.isUpperOpen)
		
		let leftOpen0RightClosed1Interval = 0<∙≤1
		XCTAssertTrue(leftOpen0RightClosed1Interval.isLowerBounded)
		XCTAssertTrue(leftOpen0RightClosed1Interval.isUpperBounded)
		XCTAssertTrue(leftOpen0RightClosed1Interval.isLowerOpen)
		XCTAssertTrue(leftOpen0RightClosed1Interval.isUpperClosed)
		
		let leftOpen0RightOpen1Interval = 0<∙<1
		XCTAssertTrue(leftOpen0RightOpen1Interval.isLowerBounded)
		XCTAssertTrue(leftOpen0RightOpen1Interval.isUpperBounded)
		XCTAssertTrue(leftOpen0RightOpen1Interval.isLowerOpen)
		XCTAssertTrue(leftOpen0RightOpen1Interval.isUpperOpen)
		
		let leftUnboundedRightClosed1Interval = ∙∙≤1
		XCTAssertTrue(leftUnboundedRightClosed1Interval.isLowerUnbounded)
		XCTAssertTrue(leftUnboundedRightClosed1Interval.isUpperBounded)
		XCTAssertTrue(leftUnboundedRightClosed1Interval.isUpperClosed)
		
		let leftUnboundedRightOpen1Interval = ∙∙<1
		XCTAssertTrue(leftUnboundedRightOpen1Interval.isLowerUnbounded)
		XCTAssertTrue(leftUnboundedRightOpen1Interval.isUpperBounded)
		XCTAssertTrue(leftUnboundedRightOpen1Interval.isUpperOpen)
		
		let leftClosed0RightUnboundedInterval = 0≤∙∙
		XCTAssertTrue(leftClosed0RightUnboundedInterval.isLowerBounded)
		XCTAssertTrue(leftClosed0RightUnboundedInterval.isUpperUnbounded)
		XCTAssertTrue(leftClosed0RightUnboundedInterval.isLowerClosed)
		
		let leftOpen0RightUnboundedInterval = 0<∙∙
		XCTAssertTrue(leftOpen0RightUnboundedInterval.isLowerBounded)
		XCTAssertTrue(leftOpen0RightUnboundedInterval.isUpperUnbounded)
		XCTAssertTrue(leftOpen0RightUnboundedInterval.isLowerOpen)
		
		//	MARK: Descending interval operators.
		
		let inverseLeftClosed0RightClosed1Interval = 1≥∙≥0
		XCTAssertTrue(inverseLeftClosed0RightClosed1Interval.isLowerBounded)
		XCTAssertTrue(inverseLeftClosed0RightClosed1Interval.isUpperBounded)
		XCTAssertTrue(inverseLeftClosed0RightClosed1Interval.isLowerClosed)
		XCTAssertTrue(inverseLeftClosed0RightClosed1Interval.isUpperClosed)
		XCTAssertTrue(inverseLeftClosed0RightClosed1Interval.isInverse)
		
		let inverseLeftClosed0RightOpen1Interval = 1>∙≥0
		XCTAssertTrue(inverseLeftClosed0RightOpen1Interval.isLowerBounded)
		XCTAssertTrue(inverseLeftClosed0RightOpen1Interval.isUpperBounded)
		XCTAssertTrue(inverseLeftClosed0RightOpen1Interval.isLowerClosed)
		XCTAssertTrue(inverseLeftClosed0RightOpen1Interval.isUpperOpen)
		XCTAssertTrue(inverseLeftClosed0RightOpen1Interval.isInverse)
		
		let inverseLeftOpen0RightClosed1Interval = 1≥∙>0
		XCTAssertTrue(inverseLeftOpen0RightClosed1Interval.isLowerBounded)
		XCTAssertTrue(inverseLeftOpen0RightClosed1Interval.isUpperBounded)
		XCTAssertTrue(inverseLeftOpen0RightClosed1Interval.isLowerOpen)
		XCTAssertTrue(inverseLeftOpen0RightClosed1Interval.isUpperClosed)
		XCTAssertTrue(inverseLeftOpen0RightClosed1Interval.isInverse)
		
		let inverseLeftOpen0RightOpen1Interval = 1>∙>0
		XCTAssertTrue(inverseLeftOpen0RightOpen1Interval.isLowerBounded)
		XCTAssertTrue(inverseLeftOpen0RightOpen1Interval.isUpperBounded)
		XCTAssertTrue(inverseLeftOpen0RightOpen1Interval.isLowerOpen)
		XCTAssertTrue(inverseLeftOpen0RightOpen1Interval.isUpperOpen)
		XCTAssertTrue(inverseLeftOpen0RightOpen1Interval.isInverse)
		
		let inverseLeftUnboundedRightClosed1Interval = 1≥∙∙
		XCTAssertTrue(inverseLeftUnboundedRightClosed1Interval.isLowerUnbounded)
		XCTAssertTrue(inverseLeftUnboundedRightClosed1Interval.isUpperBounded)
		XCTAssertTrue(inverseLeftUnboundedRightClosed1Interval.isUpperClosed)
		XCTAssertTrue(inverseLeftUnboundedRightClosed1Interval.isInverse)
		
		let inverseLeftUnboundedRightOpen1Interval = 1>∙∙
		XCTAssertTrue(inverseLeftUnboundedRightOpen1Interval.isLowerUnbounded)
		XCTAssertTrue(inverseLeftUnboundedRightOpen1Interval.isUpperBounded)
		XCTAssertTrue(inverseLeftUnboundedRightOpen1Interval.isUpperOpen)
		XCTAssertTrue(inverseLeftUnboundedRightOpen1Interval.isInverse)
		
		let inverseLeftClosed0RightUnboundedInterval = ∙∙≥0
		XCTAssertTrue(inverseLeftClosed0RightUnboundedInterval.isLowerBounded)
		XCTAssertTrue(inverseLeftClosed0RightUnboundedInterval.isUpperUnbounded)
		XCTAssertTrue(inverseLeftClosed0RightUnboundedInterval.isLowerClosed)
		XCTAssertTrue(inverseLeftClosed0RightUnboundedInterval.isInverse)
		
		let inverseLeftOpen0RightUnboundedInterval = ∙∙>0
		XCTAssertTrue(inverseLeftOpen0RightUnboundedInterval.isLowerBounded)
		XCTAssertTrue(inverseLeftOpen0RightUnboundedInterval.isUpperUnbounded)
		XCTAssertTrue(inverseLeftOpen0RightUnboundedInterval.isLowerOpen)
		XCTAssertTrue(inverseLeftOpen0RightUnboundedInterval.isInverse)
		
    }
	
	///	An array of all test cases.
	///
	///	This constant informs `XCTestManifests.swift` of what cases there are to test.
    static let allTests = [
        ("testIntervalOperators", testIntervalOperators),
    ]
}
