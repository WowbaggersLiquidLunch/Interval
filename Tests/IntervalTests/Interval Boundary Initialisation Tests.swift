//
//	Interval Boundary Initialisation Tests.swift - Test cases and methods regarding instantiating a boundary condition.
//
//	Created by Wowbagger & His Liquid Lunch on 20-08-16.
//

import XCTest
@testable import Interval

///	A group of test cases and methods regarding instantiating a boundary condition.
final class IntervalBoundaryInitialisationTests: XCTestCase {
	
	///	Checks that interval boundary accessibilities adapt correctly to their equivalent availabilities.
	func testAdaptingFromBoundaryAccessibilityToAvailability() {
		XCTAssertEqual(
			IntervalBoundaryAvailability(accessibility: .closed),
			IntervalBoundaryAvailability.inclusive,
			"Fails to adapt a closed boundary to an inclusive boundary."
		)
		XCTAssertEqual(
			IntervalBoundaryAvailability(accessibility: .open),
			IntervalBoundaryAvailability.exclusive,
			"Fails to adapt an open boundary to an exclusive boundary."
		)
	}
	
	///	Checks that interval boundary availabilities adapt correctly to their equivalent accessibilities.
	func testAdaptingFromBoundaryAvailabilityToAccessibility() {
		XCTAssertEqual(
			IntervalBoundaryAccessibility(availability: .inclusive),
			IntervalBoundaryAccessibility.closed,
			"Fails to adapt an inclusive boundary to a closed boundary."
		)
		XCTAssertEqual(
			IntervalBoundaryAccessibility(availability: .exclusive),
			IntervalBoundaryAccessibility.open,
			"Fails to adapt an exclusive boundary to an open boundary."
		)
	}
	
}
