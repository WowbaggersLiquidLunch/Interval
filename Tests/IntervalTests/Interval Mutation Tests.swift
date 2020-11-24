//
//	Interval Mutation Tests.swift - Test cases and methods regarding mutating an interval.
//
//	Created by Wowbagger & His Liquid Lunch on 20-09-09.
//

import XCTest
@testable import Interval

///	A group of test cases and methods regarding mutating an interval.
class IntervalMutationTests: XCTestCase {
	
	///	Checks that `reverse()` reverses an interval's iterating direction correctly.
	func testReversingIntervalIteratingDirection() {
		
		///	Pairs of interval-forming operators that create bounded intervals.
		///
		///	Each pair differ only in the iterating direction of the intervals they create.
		let boundedIntervalFormationOperatorPairs: [(formAscendingInterval: (Int, Int) -> Interval<Int>, formDescendingInterval: (Int, Int) -> Interval<Int>)] = [
			(≤∙≤, ≥∙≥),
			(≤∙<, >∙≥),
			(<∙≤, ≥∙>),
			(<∙<, >∙>)
		]
		
		///	Pairs of interval-forming operators that create half-bounded intervals.
		///
		///	Each pair differ only in the iterating direction of the intervals they create.
		let halfUnboundedIntervalFormationOperatorPairs: [(formAscendingInterval: (Int) -> Interval<Int>, formDescendingInterval: (Int) -> Interval<Int>)] = [
			(∙∙≤, ≥∙∙),
			(∙∙<, >∙∙),
			(≤∙∙, ∙∙≥),
			(<∙∙, ∙∙>)
		]
		
		///	The collection of bounded endpoint values for testing `reverse()`.
		let boundedEndpointValues = [0, 1]
		
		boundedEndpointValues.forEach { lowerBoundedEndpointValue in
			
			boundedEndpointValues.forEach { upperBoundedEndpointValue in
				boundedIntervalFormationOperatorPairs.forEach { formAscendingInterval, formDescendingInterval in
					
					var originallyAscendinglyIteratedInterval = formAscendingInterval(lowerBoundedEndpointValue, upperBoundedEndpointValue)
					var originallyDescendinglyIteratedInterval = formDescendingInterval(upperBoundedEndpointValue, lowerBoundedEndpointValue)
					
					originallyAscendinglyIteratedInterval.reverse()
					originallyDescendinglyIteratedInterval.reverse()
					
					compareIntervals(
						originallyAscendinglyIteratedInterval,
						formDescendingInterval(upperBoundedEndpointValue, lowerBoundedEndpointValue),
						failureMessage: "Ascendingly iterated interval \(formAscendingInterval(lowerBoundedEndpointValue, upperBoundedEndpointValue)) fails to reverse its interating direction."
					)
					compareIntervals(
						originallyDescendinglyIteratedInterval,
						formAscendingInterval(lowerBoundedEndpointValue, upperBoundedEndpointValue),
						failureMessage: "Descendingly iterated interval \(formDescendingInterval(upperBoundedEndpointValue, lowerBoundedEndpointValue)) fails to reverse its interating direction."
					)
					
				}
			}
			
			halfUnboundedIntervalFormationOperatorPairs.forEach { formAscendingInterval, formDescendingInterval in
				
				var originallyAscendinglyIteratedInterval = formAscendingInterval(lowerBoundedEndpointValue)
				var originallyDescendinglyIteratedInterval = formDescendingInterval(lowerBoundedEndpointValue)
				
				originallyAscendinglyIteratedInterval.reverse()
				originallyDescendinglyIteratedInterval.reverse()
				
				compareIntervals(
					originallyAscendinglyIteratedInterval,
					formDescendingInterval(lowerBoundedEndpointValue),
					failureMessage: "Ascendingly iterated interval \(formAscendingInterval(lowerBoundedEndpointValue)) fails to reverse its interating direction."
				)
				compareIntervals(
					originallyDescendinglyIteratedInterval,
					formAscendingInterval(lowerBoundedEndpointValue),
					failureMessage: "Descendingly iterated interval \(formDescendingInterval(lowerBoundedEndpointValue)) fails to reverse its interating direction."
				)
				
			}
			
		}
		
		///	Compares 2 intervals member-wisely.
		///	- Parameters:
		///	  - interval1: An interval to compare.
		///	  - interval2: Another interval to compare.
		///	  - failureMessage: An optional description of a failure.
		func compareIntervals<Member>(_ interval1: Interval<Member>, _ interval2: Interval<Member>, failureMessage: String = "") {
			XCTAssertEqual(
				interval1.lowerBoundaryAccessibility,
				interval2.lowerBoundaryAccessibility,
				failureMessage
			)
			XCTAssertEqual(
				interval1.lowerEndpoint,
				interval2.lowerEndpoint,
				failureMessage
			)
			XCTAssertEqual(
				interval1.upperEndpoint,
				interval2.upperEndpoint,
				failureMessage
			)
			XCTAssertEqual(
				interval1.upperBoundaryAccessibility,
				interval2.upperBoundaryAccessibility,
				failureMessage
			)
			XCTAssertEqual(
				interval1.isInverse,
				interval2.isInverse,
				failureMessage
			)
		}
		
	}
	
}
