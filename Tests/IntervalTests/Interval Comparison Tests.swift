//
//	Interval Comparison Tests.swift - Test cases and methods regarding comparison between intervals.
//
//	Created by Wowbagger & His Liquid Lunch on 20-09-17.
//

import XCTest
@testable import Interval

///	A group of test cases and methods regarding comparison between intervals.
class IntervalComparisonTests: XCTestCase {
	
	///	The collection of bounded endpoint values for testing interval comparison.
	var boundedEndpointValues: [Int] = [.min, -1, 0, 1, 2, .max]
	///	The collection of endpoints for testing interval comparison.
	var endpoints: [Interval<Int>.Endpoint] { boundedEndpointValues.map { .bounded($0) } + [.unbounded] }
	
	///	The collection of boundary accessibilities for testing interval comparison.
	let boundaryAccessibilities: [IntervalBoundaryAccessibility] = [.closed, .open]
	///	The collection of boundary availabilities for testing interval comparison.
	let boundaryAvailabilities: [IntervalBoundaryAvailability] = [.inclusive, .exclusive]
	
	///	The collection of interval striding directions for testing interval comparison.
	let whetherIntervalShouldBeOrderedDescendingly: [Bool] = [true, false]
	
	///	Returns a Boolean value indicating whether `interval1`'s lowest accessible member is no lesser than `interval2`'s.
	///	- Parameters:
	///	  - interval1: An interval.
	///	  - interval2: Another interval.
	///	- Returns: `true`, if `interval1` is empty or a subinterval of non-empty `interval2`, assuming both are upper-unbounded; otherwise, `false`.
	func assumingBothAreUpperUnbounded<Member>(_ interval1: Interval<Member>, isContainedWithin interval2: Interval<Member>) -> Bool {
		if interval1.isEmpty {
			return true
		} else if interval2.isEmpty {
			return false
		}
		switch (interval1.lowerEndpoint, interval2.lowerEndpoint) {
		case (_, .unbounded):
			return true
		case (.unbounded, .bounded):
			return false
		case let (.bounded(lowerEndpointValue1), .bounded(lowerEndpointValue2)):
			switch (interval1.lowerBoundaryAccessibility, interval2.lowerBoundaryAccessibility) {
			case (.closed, .open):
				return lowerEndpointValue1 > lowerEndpointValue2
			default:
				return lowerEndpointValue1 >= lowerEndpointValue2
			}
		}
	}
	
	///	Returns a Boolean value indicating whether `interval1`'s highest accessible member is no greater than `interval2`'s.
	///	- Parameters:
	///	  - interval1: An interval.
	///	  - interval2: Another interval.
	///	- Returns: `true`, if `interval1` is empty or a subinterval of non-empty `interval2`, assuming both are lower-unbounded; otherwise, `false`.
	func assumingBothAreLowerUnbounded<Member>(_ interval1: Interval<Member>, isContainedWithin interval2: Interval<Member>) -> Bool {
		if interval1.isEmpty {
			return true
		} else if interval2.isEmpty {
			return false
		}
		switch (interval1.upperEndpoint, interval2.upperEndpoint) {
		case (_, .unbounded):
			return true
		case (.unbounded, .bounded):
			return false
		case let (.bounded(upperEndpointValue1), .bounded(upperEndpointValue2)):
			switch (interval1.upperBoundaryAccessibility, interval2.upperBoundaryAccessibility) {
			case (.closed, .open):
				return upperEndpointValue1 < upperEndpointValue2
			default:
				return upperEndpointValue1 <= upperEndpointValue2
			}
		}
	}
	
	#if false
	
	//	FIXME: Fix `testIntervalContainment()`.
	
	///	Checks that intervals compare for containment correctly.
	func testIntervalContainment() {
		
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
												
												let assumingBothAreUpperUnboundedInterval1IsContainedWithinInterval2 = assumingBothAreUpperUnbounded(interval1, isContainedWithin: interval2)
												let assumingBothAreUpperUnboundedInterval2IsContainedWithinInterval1 = assumingBothAreUpperUnbounded(interval2, isContainedWithin: interval1)
												let assumingBothAreLowerUnboundedInterval1IsContainedWithinInterval2 = assumingBothAreLowerUnbounded(interval1, isContainedWithin: interval2)
												let assumingBothAreLowerUnboundedInterval2IsContainedWithinInterval1 = assumingBothAreLowerUnbounded(interval2, isContainedWithin: interval1)
												
												let interval1IsSubintervalOfInterval2 = assumingBothAreUpperUnboundedInterval1IsContainedWithinInterval2 && assumingBothAreLowerUnboundedInterval1IsContainedWithinInterval2
												let interval1IsSuperintervalOfInterval2 = assumingBothAreUpperUnboundedInterval2IsContainedWithinInterval1 && assumingBothAreLowerUnboundedInterval2IsContainedWithinInterval1
												
												let interval1IsStrictSubintervalOfInterval2 = interval1IsSubintervalOfInterval2 && interval1 != interval2
												let interval1IsStrictSuperintervalOfInterval2 = interval1IsSuperintervalOfInterval2 && interval1 != interval2
												
												XCTAssertEqual(
													interval1.isSubinterval(of: interval2),
													interval1IsSubintervalOfInterval2,
													"""
													\(interval1) should \(interval1IsSubintervalOfInterval2 ? "" : "not ")be a subinterval of \(interval2), \
													because \(interval1.isEmpty ? "\(interval1) is ∅, and " : "")\(interval2.isEmpty ? "\(interval2) is ∅, and " : "")\
													\(interval1.isEmpty ? "∅" : "\(interval1)") \(interval1IsSubintervalOfInterval2 ? "⊆" : "⊈") \(interval2.isEmpty ? "∅" : "\(interval2)").
													"""
												)
												
												XCTAssertEqual(
													interval1.isSuperinterval(of: interval2),
													interval1IsSuperintervalOfInterval2,
													"""
													\(interval1) should \(interval1IsSuperintervalOfInterval2 ? "" : "not ")be a superinterval of \(interval2), \
													because \(interval1.isEmpty ? "\(interval1) is ∅, and " : "")\(interval2.isEmpty ? "\(interval2) is ∅, and " : "")\
													\(interval1.isEmpty ? "∅" : "\(interval1)") \(interval1IsSuperintervalOfInterval2 ? "⊇" : "⊉") \(interval2.isEmpty ? "∅" : "\(interval2)").
													"""
												)
												
												XCTAssertEqual(
													interval1.isStrictSubinterval(of: interval1),
													interval1IsStrictSubintervalOfInterval2,
													"""
													\(interval1) should \(interval1IsStrictSubintervalOfInterval2 ? "" : "not ")be a proper (strict) subinterval of \(interval2), \
													because \(interval1.isEmpty ? "\(interval1) is ∅, and " : "")\(interval2.isEmpty ? "\(interval2) is ∅, and " : "")\
													\(interval1.isEmpty ? "∅" : "\(interval1)") \(interval1IsStrictSubintervalOfInterval2 ? "⊊" : "⊄") \(interval2.isEmpty ? "∅" : "\(interval2)").
													"""
												)
												
												XCTAssertEqual(
													interval1.isStrictSuperinterval(of: interval2),
													interval1IsStrictSuperintervalOfInterval2,
													"""
													\(interval1) should \(interval1IsStrictSuperintervalOfInterval2 ? "" : "not ")be a proper (strict) superinterval of \(interval2), \
													because \(interval1.isEmpty ? "\(interval1) is ∅, and " : "")\(interval2.isEmpty ? "\(interval2) is ∅, and " : "")\
													\(interval1.isEmpty ? "∅" : "\(interval1)") \(interval1IsStrictSuperintervalOfInterval2 ? "⊋" : "⊅") \(interval2.isEmpty ? "∅" : "\(interval2)").
													"""
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
	
	#endif
	
}
