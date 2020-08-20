//
//	Interval Properties Tests.swift - Test cases and methods regarding interval properties.
//
//	Created by Wowbagger & His Liquid Lunch on 20-08-10.
//

import XCTest
@testable import Interval

///	A group of test cases and methods regarding interval properties.
final class IntervalPropertiesTests: XCTestCase {
	
	///	Checks that an internal has correct properties after initialisation.
	func testIntervalProperties() {
		
		///	The lesser bounded endpoint value for testing interval properties.
		let lesserBoundedEndpointValue = 0
		///	The greater bounded endpoint value for testing interval properties.
		let greaterBoundedEndpointValue = 1
		
		///	The lesser bounded endpoint for testing interval properties.
		let lesserBoundedEndpoint: Interval<Int>.Endpoint = .bounded(lesserBoundedEndpointValue)
		///	The greater bounded endpoint for testing interval properties.
		let greaterBoundedEndpoint: Interval<Int>.Endpoint = .bounded(greaterBoundedEndpointValue)
		
		///	The collection of endpoints for testing interval properties.
		let endpoints: [Interval<Int>.Endpoint] = [lesserBoundedEndpoint, greaterBoundedEndpoint, .unbounded]
		
		///	The collection of boundary accessibilities for testing interval properties.
		let boundaryAccessibilities: [IntervalBoundaryAccessibility] = [.closed, .open]
//		///	The collection of boundary availabilities for testing interval properties.
//		let boundaryAvailabilities: [IntervalBoundaryAvailability] = [.inclusive, .exclusive]
		
		///	The collection of interval striding directions for testing interval properties.
		let whetherIntervalShouldBeOrderedDescendingly: [Bool] = [true, false]
		
		endpoints.forEach { lowerEndpoint in
			endpoints.forEach { upperEndpoint in
				boundaryAccessibilities.forEach { lowerBoundaryAccessibility in
					boundaryAccessibilities.forEach { upperBoundaryAccessibility in
						whetherIntervalShouldBeOrderedDescendingly.forEach { intervalShouldBeOrderedDescendingly in
							
							let interval = Interval(
								lowerBoundary: lowerBoundaryAccessibility,
								lowerEndpoint: lowerEndpoint,
								upperEndpoint: upperEndpoint,
								upperBoundary: upperBoundaryAccessibility,
								inInverseStridingDirection: intervalShouldBeOrderedDescendingly
							)
							
							//	MARK: Test Interval-Defining Properties
							
							XCTAssertEqual(
								interval.lowerBoundaryAccessibility,
								lowerBoundaryAccessibility,
								"Fails to instantiate a lower-\(lowerBoundaryAccessibility) interval."
							)
							XCTAssertEqual(
								interval.upperBoundaryAccessibility,
								upperBoundaryAccessibility,
								"Fails to instantiate an upper-\(upperBoundaryAccessibility) interval."
							)
							
							XCTAssertEqual(
								interval.lowerBoundaryAvailability,
								IntervalBoundaryAvailability(accessibility: lowerBoundaryAccessibility),
								"Fails to instantiate a lowerEndpoint-\(IntervalBoundaryAvailability(accessibility: lowerBoundaryAccessibility)) interval."
							)
							XCTAssertEqual(
								interval.upperBoundaryAvailability,
								IntervalBoundaryAvailability(accessibility: upperBoundaryAccessibility),
								"Fails to instantiate an upperEndpoint-\(IntervalBoundaryAvailability(accessibility: upperBoundaryAccessibility)) interval."
							)
							
							if case let .bounded(lowerBoundedEndpointValue) = lowerEndpoint {
								XCTAssertEqual(
									interval.lowerEndpoint,
									lowerEndpoint,
									"Fails to instantiate an interval lower-bounded by \(lowerBoundedEndpointValue)."
								)
							} else {
								XCTAssertEqual(
									interval.lowerEndpoint,
									.unbounded,
									"Fails to instantiate a lower-unbounded interval."
								)
							}
							
							if case let .bounded(upperBoundedEndpointValue) = upperEndpoint {
								XCTAssertEqual(
									interval.upperEndpoint,
									upperEndpoint,
									"Fails to instantiate an interval upper-bounded by \(upperBoundedEndpointValue)."
								)
							} else {
								XCTAssertEqual(
									interval.upperEndpoint,
									.unbounded,
									"Fails to instantiate an upper-unbounded interval."
								)
							}
							
							XCTAssertEqual(
								interval.isInverse,
								intervalShouldBeOrderedDescendingly,
								"Fails to instantiate \(intervalShouldBeOrderedDescendingly ? "a descendingly" : "an ascendingly") ordered interval."
							)
							
							//	MARK: Test Interval Boundaries
							
							XCTAssertEqual(
								interval.isClosed,
								lowerBoundaryAccessibility == .closed && upperBoundaryAccessibility == .closed,
								"`Interval`'s instance property `isClosed` fails to evaluate correctly."
							)
							
							XCTAssertEqual(
								interval.isOpen,
								lowerBoundaryAccessibility == .open && upperBoundaryAccessibility == .open,
								"`Interval`'s instance property `isOpen` fails to evaluate correctly."
							)
							
							XCTAssertEqual(
								interval.isHalfOpen,
								(lowerBoundaryAccessibility == .closed && upperBoundaryAccessibility == .open) || (lowerBoundaryAccessibility == .open && upperBoundaryAccessibility == .closed),
								"`Interval`'s instance property `isHalfOpen` fails to evaluate correctly."
							)
							
							XCTAssertEqual(
								interval.isLowerClosed,
								lowerBoundaryAccessibility == .closed,
								"`Interval`'s instance property `isLowerClosed` fails to evaluate correctly."
							)
							
							XCTAssertEqual(
								interval.isUpperClosed,
								upperBoundaryAccessibility == .closed,
								"`Interval`'s instance property `isUpperClosed` fails to evaluate correctly."
							)
							
							XCTAssertEqual(
								interval.isLowerOpen,
								lowerBoundaryAccessibility == .open,
								"`Interval`'s instance property `isLowerOpen` fails to evaluate correctly."
							)
							
							XCTAssertEqual(
								interval.isUpperOpen,
								upperBoundaryAccessibility == .open,
								"`Interval`'s instance property `isUpperOpen` fails to evaluate correctly."
							)
							
							//	MARK: Test Interval Endpoints
							
							XCTAssertEqual(
								interval.isBounded,
								lowerEndpoint != .unbounded && upperEndpoint != .unbounded,
								"`Interval`'s instance property `isBounded` fails to evaluate correctly."
							)
							
							XCTAssertEqual(
								interval.isUnbounded,
								lowerEndpoint == .unbounded && upperEndpoint == .unbounded,
								"`Interval`'s instance property `isUnbounded` fails to evaluate correctly."
							)
							
							XCTAssertEqual(
								interval.isHalfBounded,
								(lowerEndpoint != .unbounded && upperEndpoint == .unbounded) || (lowerEndpoint == .unbounded && upperEndpoint != .unbounded),
								"`Interval`'s instance property `isHalfBounded` fails to evaluate correctly."
							)
							
							XCTAssertEqual(
								interval.isLowerBounded,
								lowerEndpoint != .unbounded,
								"`Interval`'s instance property `isLowerBounded` fails to evaluate correctly."
							)
							
							XCTAssertEqual(
								interval.isUpperBounded,
								upperEndpoint != .unbounded,
								"`Interval`'s instance property `isUpperBounded` fails to evaluate correctly."
							)
							
							XCTAssertEqual(
								interval.isLowerUnbounded,
								lowerEndpoint == .unbounded,
								"`Interval`'s instance property `isLowerUnbounded` fails to evaluate correctly."
							)
							
							XCTAssertEqual(
								interval.isUpperUnbounded,
								upperEndpoint == .unbounded,
								"`Interval`'s instance property `isUpperUnbounded` fails to evaluate correctly."
							)
							
						}
					}
				}
			}
		}
		
	}
	
}
