//
//	Interval Properties Tests.swift - Test cases and methods regarding interval properties.
//
//	Created by Wowbagger & His Liquid Lunch on 20-08-10.
//

import XCTest
@testable import Interval

///	A group of test cases and methods regarding interval properties.
final class IntervalPropertiesTests: XCTestCase {
	
	///	The collection of bounded endpoint values of type `UInt` for testing interval properties.
	let boundedEndpointValuesOfTypeUInt: [UInt] = [.min, 0, 1, 2, 3, .max]
	///	The collection of bounded endpoint values of type `Int` for testing interval properties.
	let boundedEndpointValuesOfTypeInt: [Int] = [.min, -1, 0, 1, 2, .max]
	///	The collection of bounded endpoint values of type `UInt64` for testing interval properties.
	let boundedEndpointValuesOfTypeUInt64: [UInt64] = [.min, 0, 1, 2, 3, .max]
	///	The collection of bounded endpoint values of type `Int64` for testing interval properties.
	let boundedEndpointValuesOfTypeInt64: [Int64] = [.min, -1, 0, 1, 2, .max]
	///	The collection of bounded endpoint values of type `UInt32` for testing interval properties.
	let boundedEndpointValuesOfTypeUInt32: [UInt32] = [.min, 0, 1, 2, 3, .max]
	///	The collection of bounded endpoint values of type `Int32` for testing interval properties.
	let boundedEndpointValuesOfTypeInt32: [Int32] = [.min, -1, 0, 1, 2, .max]
	///	The collection of bounded endpoint values of type `UInt16` for testing interval properties.
	let boundedEndpointValuesOfTypeUInt16: [UInt16] = [.min, 0, 1, 2, 3, .max]
	///	The collection of bounded endpoint values of type `Int16` for testing interval properties.
	let boundedEndpointValuesOfTypeInt16: [Int16] = [.min, -1, 0, 1, 2, .max]
	///	The collection of bounded endpoint values of type `UInt8` for testing interval properties.
	let boundedEndpointValuesOfTypeUInt8: [UInt8] = [.min, 0, 1, 2, 3, .max]
	///	The collection of bounded endpoint values of type `Int8` for testing interval properties.
	let boundedEndpointValuesOfTypeInt8: [Int8] = [.min, -1, 0, 1, 2, .max]
	///	The collection of bounded endpoint values of type `Double` for testing interval properties.
	let boundedEndpointValuesOfTypeDouble: [Double] = [-1, 0, .leastNonzeroMagnitude, 0.5, 1, 2, .pi, .greatestFiniteMagnitude, .infinity]
	///	The collection of bounded endpoint values of type `String` for testing interval properties.
	let boundedEndpointValuesOfTypeString: [String] = ["a", "b", "ç", "π", "the", "internet", "is", "made", "of", "cats"]
	
	///	The collection of bounded endpoints of type `Int`for testing interval properties.
	var boundedEndpointsOfTypeInt: [Interval<Int>.Endpoint] { boundedEndpointValuesOfTypeInt.map { .bounded($0) } }
	///	The collection of endpoints (bounded and unbounded) of type `Int` for testing interval properties.
	var endpointsOfTypeInt: [Interval<Int>.Endpoint] { boundedEndpointsOfTypeInt + [.unbounded] }
	
	///	The collection of boundary accessibilities for testing interval properties.
	let boundaryAccessibilities: [IntervalBoundaryAccessibility] = [.closed, .open]
	//		///	The collection of boundary availabilities for testing interval properties.
	//		let boundaryAvailabilities: [IntervalBoundaryAvailability] = [.inclusive, .exclusive]
	
	///	The collection of interval striding directions for testing interval properties.
	let whetherIntervalShouldBeOrderedDescendingly: [Bool] = [true, false]
	
	///	Checks that internal have correct properties after initialisation.
	func testIntervalBoundariesAndEndpoints() {
		
		endpointsOfTypeInt.forEach { lowerEndpoint in
			endpointsOfTypeInt.forEach { upperEndpoint in
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
	
	///	Checks that intervals evaluate their cardinality correctly.
	func testIntervalCardinality() {
		
		//	MARK: Collections of Countable Types
		
		//	Currently, as of Swift 5.3, the only `Countable`-conformable types in the standard library are `BinaryInteger` conforming types, which are basically just the 10 integer types. The reason all 10 types need to be included in this test case is because of the integer overflow that could happen in `Strideable`'s `advance(by:)` and `distance(to:)` methods. For more details, see documentation on `Countable`.
		
		///	Checks that intervals possibly bounded by any of the given endpoint values evaluate their cardinality correctly
		///	- Parameter boundedEndpointsValues: The given endpoint values.
		func testCardinalityOfIntervals<T: IntervalMember>(possiblyBoundedByAnyOf boundedEndpointsValues: [T]) {
			
			let endpoints: [Interval<T>.Endpoint] = boundedEndpointsValues.map { .bounded($0) } + [.unbounded]
			
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
								
								if case let .bounded(lowerBoundedEndpointValue) = lowerEndpoint, case let .bounded(upperBoundedEndpointValue) = upperEndpoint {
									let intervalIsEmpty = lowerBoundedEndpointValue > upperBoundedEndpointValue || (!interval.isClosed && lowerBoundedEndpointValue == upperBoundedEndpointValue) || (interval.isOpen && lowerBoundedEndpointValue.borders(on: upperBoundedEndpointValue))
									XCTAssertEqual(
										interval.isEmpty,
										intervalIsEmpty,
										"`Interval`'s instance property `isEmpty` fails to evaluate to `\(intervalIsEmpty)` for interval \(interval)."
									)
								} else {
									XCTAssertFalse(interval.isEmpty, "`Interval`'s instance property `isEmpty` fails to evaluate to `false` for \(interval).")
								}
								
								if case let .bounded(lowerBoundedEndpointValue) = lowerEndpoint, case let .bounded(upperBoundedEndpointValue) = upperEndpoint {
									let intervalIsDegenerate = (interval.isClosed && lowerBoundedEndpointValue == upperBoundedEndpointValue)
										|| lowerBoundedEndpointValue < upperBoundedEndpointValue && (
											(interval.isHalfOpen && lowerBoundedEndpointValue.borders(on: upperBoundedEndpointValue)) || (interval.isOpen && lowerBoundedEndpointValue.sharesCommonNeighbor(with: upperBoundedEndpointValue))
										)
									XCTAssertEqual(
										interval.isDegenerate,
										intervalIsDegenerate,
										"`Interval`'s instance property `isDegenerate` fails to evaluate to `\(intervalIsDegenerate)` for interval \(interval)."
									)
								} else {
									XCTAssertFalse(interval.isDegenerate, "`Interval`'s instance property `isDegenerate` fails to evaluate to `false` for \(interval).")
								}
								
								if case let .bounded(lowerBoundedEndpointValue) = lowerEndpoint, case let .bounded(upperBoundedEndpointValue) = upperEndpoint {
									let intervalIsProper = lowerBoundedEndpointValue < upperBoundedEndpointValue && (
										interval.isClosed || !lowerBoundedEndpointValue.borders(on: upperBoundedEndpointValue) && (
											interval.isHalfOpen || (interval.isOpen && !lowerBoundedEndpointValue.sharesCommonNeighbor(with: upperBoundedEndpointValue))
										)
									)
									XCTAssertEqual(
										interval.isProper,
										intervalIsProper,
										"`Interval`'s instance property `isProper` fails to evaluate to `\(intervalIsProper)` for \(interval)."
									)
								} else {
									XCTAssertTrue(interval.isProper, "`Interval`'s instance property `isProper` fails to evaluate to `true` for \(interval).")
								}
								
							}
						}
					}
				}
			}
			
		}
		
		testCardinalityOfIntervals(possiblyBoundedByAnyOf: boundedEndpointValuesOfTypeUInt)
		testCardinalityOfIntervals(possiblyBoundedByAnyOf: boundedEndpointValuesOfTypeInt)
		testCardinalityOfIntervals(possiblyBoundedByAnyOf: boundedEndpointValuesOfTypeUInt64)
		testCardinalityOfIntervals(possiblyBoundedByAnyOf: boundedEndpointValuesOfTypeInt64)
		testCardinalityOfIntervals(possiblyBoundedByAnyOf: boundedEndpointValuesOfTypeUInt32)
		testCardinalityOfIntervals(possiblyBoundedByAnyOf: boundedEndpointValuesOfTypeInt32)
		testCardinalityOfIntervals(possiblyBoundedByAnyOf: boundedEndpointValuesOfTypeUInt16)
		testCardinalityOfIntervals(possiblyBoundedByAnyOf: boundedEndpointValuesOfTypeInt16)
		testCardinalityOfIntervals(possiblyBoundedByAnyOf: boundedEndpointValuesOfTypeUInt8)
		testCardinalityOfIntervals(possiblyBoundedByAnyOf: boundedEndpointValuesOfTypeInt8)
		testCardinalityOfIntervals(possiblyBoundedByAnyOf: boundedEndpointValuesOfTypeDouble)
		testCardinalityOfIntervals(possiblyBoundedByAnyOf: boundedEndpointValuesOfTypeString)
		
	}
	
}
