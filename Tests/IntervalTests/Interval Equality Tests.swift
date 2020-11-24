//
//	Interval Equality Tests.swift - Test cases and methods regarding equality between intervals.
//
//	Created by Wowbagger & His Liquid Lunch on 20-09-17.
//

import XCTest
@testable import Interval

///	A group of test cases and methods regarding `Interval`'s `Equatable` conformance.
class IntervalEqualityTests: XCTestCase {
	
	///	The lesser bounded endpoint value for testing interval equality.
	let lesserBoundedEndpointValue = 0
	///	The greater bounded endpoint value for testing interval equality.
	let greaterBoundedEndpointValue = 1
	///	The collection of bounded endpoint values for testing interval equality.
	var boundedEndpointValues: [Int] { [lesserBoundedEndpointValue, greaterBoundedEndpointValue] }
	
	///	The lesser bounded endpoint for testing interval equality.
	var lesserBoundedEndpoint: Interval<Int>.Endpoint { .bounded(lesserBoundedEndpointValue) }
	///	The greater bounded endpoint for testing interval equality.
	var greaterBoundedEndpoint: Interval<Int>.Endpoint { .bounded(greaterBoundedEndpointValue) }
	///	The collection of endpoints for testing interval equality.
	var endpoints: [Interval<Int>.Endpoint] { [lesserBoundedEndpoint, greaterBoundedEndpoint, .unbounded] }
	
	///	The collection of boundary accessibilities for testing interval equality.
	let boundaryAccessibilities: [IntervalBoundaryAccessibility] = [.closed, .open]
	///	The collection of boundary availabilities for testing interval equality.
	let boundaryAvailabilities: [IntervalBoundaryAvailability] = [.inclusive, .exclusive]
	
	///	The collection of interval striding directions for testing interval equality.
	let whetherIntervalShouldBeOrderedDescendingly: [Bool] = [true, false]
	
	///	Verifies that intervals are equal if their defining properties are equal or if they're both empty.
	func testsEqualityBetweenIntervals() {
		
		endpoints.forEach { lowerEndpoint1 in
			endpoints.forEach { upperEndpoint1 in
				boundaryAccessibilities.forEach { lowerBoundaryAccessibility1 in
					boundaryAccessibilities.forEach { upperBoundaryAccessibility1 in
						whetherIntervalShouldBeOrderedDescendingly.forEach { intervalShouldBeOrderedDescendingly1 in
							
							let interval1 = Interval(
								lowerBoundary: lowerBoundaryAccessibility1,
								lowerEndpoint: lowerEndpoint1,
								upperEndpoint: upperEndpoint1,
								upperBoundary: upperBoundaryAccessibility1,
								inInverseStridingDirection: intervalShouldBeOrderedDescendingly1
							)
							
							endpoints.forEach { lowerEndpoint2 in
								endpoints.forEach { upperEndpoint2 in
									boundaryAccessibilities.forEach { lowerBoundaryAccessibility2 in
										boundaryAccessibilities.forEach { upperBoundaryAccessibility2 in
											whetherIntervalShouldBeOrderedDescendingly.forEach { intervalShouldBeOrderedDescendingly2 in
												
												let interval2 = Interval(
													lowerBoundary: lowerBoundaryAccessibility2,
													lowerEndpoint: lowerEndpoint2,
													upperEndpoint: upperEndpoint2,
													upperBoundary: upperBoundaryAccessibility2,
													inInverseStridingDirection: intervalShouldBeOrderedDescendingly2
												)
												
												let intervalsAreEqual = (interval1.lowerBoundaryAccessibility, interval1.lowerEndpoint, interval1.upperEndpoint, interval1.upperBoundaryAccessibility) == (interval2.lowerBoundaryAccessibility, interval2.lowerEndpoint, interval2.upperEndpoint, interval2.upperBoundaryAccessibility) || (interval1.isEmpty && interval2.isEmpty)
												
												XCTAssertEqual(
													interval1 == interval2,
													intervalsAreEqual,
													"Intervals \(interval1) and \(interval2) should \(intervalsAreEqual ? "" : "not ")be equal."
												)
												
											}
										}
									}
								}
							}
							
						}
					}
				}
			}
		}
		
	}
	
}
