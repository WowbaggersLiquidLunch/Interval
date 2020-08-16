//
//	Interval Boundary Independence Tests.swift - Test cases and methods regarding interval boundaries' independence from intervals.
//
//	Created by Wowbagger & His Liquid Lunch on 20-08-16.
//

import XCTest
@testable import Interval

///	A group of test cases and methods regarding `IntervalBoundaryAccessibility` and `IntervalBoundaryAvailability`'s independence from `Interval`.
final class IntervalBoundaryIndependenceTests: XCTestCase {
	
	///	Checks that `IntervalBoundaryAccessibility` is not bounded by `Interval.Member`.
	func testIndependenceOfIntervalBoundaryAccessibilityFromInterval() {
		
		let intervalOfInts: Interval<Int> = 0≤∙≤1
		let intervalOfDoubles: Interval<Double> = 2.7≤∙≤3.14
		
		XCTAssertEqual(
			intervalOfInts.lowerBoundaryAccessibility,
			intervalOfDoubles.lowerBoundaryAccessibility,
			"`IntervalBoundaryAccessibility` fails to be independent from `Interval`."
		)
		
	}
	
}
