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
		
		///	The lower-bounded endpoint value for testing initialisations.
		let lowerBoundedEndpointValue = 0
		///	The upper-bounded endpoint value for testing initialisations.
		let upperBoundedEndpointValue = 1
		
		///	The lower-bounded endpoint for testing initialisations.
		let lowerBoundedEndpoint: Interval<Int>.Endpoint = .bounded(lowerBoundedEndpointValue)
		///	The upper-bounded endpoint for testing initialisations.
		let upperBoundedEndpoint: Interval<Int>.Endpoint = .bounded(upperBoundedEndpointValue)
		
		///	The collection of lower-bounded endpoints for testing initialisations.
		let lowerEndpoints: [Interval<Int>.Endpoint] = [lowerBoundedEndpoint, .unbounded]
		///	The collection of upper-bounded endpoints for testing initialisations.
		let upperEndpoints: [Interval<Int>.Endpoint] = [upperBoundedEndpoint, .unbounded]
		
		///	The collection of boundary accessibilities for testing initialisations.
		let boundaryAccessibilities: [IntervalBoundaryAccessibility] = [.closed, .open]
//		///	The collection of boundary availabilities for testing initialisations.
//		let boundaryAvailabilities: [IntervalBoundaryAvailability] = [.inclusive, .exclusive]
		
		///	The collection of interval striding directions for testing initialisations.
		let whetherIntervalShouldBeOrderedDescendingly: [Bool] = [true, false]
		
		lowerEndpoints.forEach { lowerEndpoint in
			upperEndpoints.forEach { upperEndpoint in
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
							
							if lowerEndpoint == lowerBoundedEndpoint {
								XCTAssertEqual(
									interval.lowerEndpoint,
									lowerBoundedEndpoint,
									"Fails to instantiate an interval lower-bounded by \(lowerBoundedEndpointValue)."
								)
							} else {
								XCTAssertEqual(
									interval.lowerEndpoint,
									.unbounded,
									"Fails to instantiate a lower-unbounded interval."
								)
							}
							
							if upperEndpoint == upperBoundedEndpoint {
								XCTAssertEqual(
									interval.upperEndpoint,
									upperBoundedEndpoint,
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
								lowerEndpoint == lowerBoundedEndpoint && upperEndpoint == upperBoundedEndpoint,
								"`Interval`'s instance property `isBounded` fails to evaluate correctly."
							)
							
							XCTAssertEqual(
								interval.isUnbounded,
								lowerEndpoint == .unbounded && upperEndpoint == .unbounded,
								"`Interval`'s instance property `isUnbounded` fails to evaluate correctly."
							)
							
							XCTAssertEqual(
								interval.isHalfBounded,
								(lowerEndpoint == lowerBoundedEndpoint && upperEndpoint == .unbounded) || (lowerEndpoint == .unbounded && upperEndpoint == upperBoundedEndpoint),
								"`Interval`'s instance property `isHalfBounded` fails to evaluate correctly."
							)
							
							XCTAssertEqual(
								interval.isLowerBounded,
								lowerEndpoint == lowerBoundedEndpoint,
								"`Interval`'s instance property `isLowerBounded` fails to evaluate correctly."
							)
							
							XCTAssertEqual(
								interval.isUpperBounded,
								upperEndpoint == upperBoundedEndpoint,
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
