//
//	Interval Initialisation Tests.swift - Test cases and methods regarding instantiating an interval.
//
//	Created by Wowbagger & His Liquid Lunch on 20-08-10.
//

import XCTest
@testable import Interval

///	A group of test cases and methods regarding instantiating `Interval`.
final class IntervalInitialisationTests: XCTestCase {
	
	///	The lower-bounded endpoint value for testing initialisations.
	let lowerBoundedEndpointValue = 0
	///	The upper-bounded endpoint value for testing initialisations.
	let upperBoundedEndpointValue = 1
	
	///	The lower-bounded endpoint for testing initialisations.
	var lowerBoundedEndpoint: Interval<Int>.Endpoint { .bounded(lowerBoundedEndpointValue) }
	///	The upper-bounded endpoint for testing initialisations.
	var upperBoundedEndpoint: Interval<Int>.Endpoint { .bounded(upperBoundedEndpointValue) }
	
	///	The collection of lower endpoints for testing initialisations.
	var lowerEndpoints: [Interval<Int>.Endpoint] { [lowerBoundedEndpoint, .unbounded] }
	///	The collection of upper endpoints for testing initialisations.
	var upperEndpoints: [Interval<Int>.Endpoint] { [upperBoundedEndpoint, .unbounded] }
	
	///	The collection of boundary accessibilities for testing initialisations.
	let boundaryAccessibilities: [IntervalBoundaryAccessibility] = [.closed, .open]
	///	The collection of boundary availabilities for testing initialisations.
	let boundaryAvailabilities: [IntervalBoundaryAvailability] = [.inclusive, .exclusive]
	
	///	The collection of interval striding directions for testing initialisations.
	let whetherIntervalShouldBeOrderedDescendingly: [Bool] = [true, false]
	
	///	Checks that `Interval`'s primary initialiser's default parameters works as intended.
	func testPrimaryInitialiser() {
		
		lowerEndpoints.forEach { lowerEndpoint in
			upperEndpoints.forEach { upperEndpoint in
				boundaryAccessibilities.forEach { lowerBoundaryAccessibility in
					boundaryAccessibilities.forEach { upperBoundaryAccessibility in
						
						XCTAssertEqual(
							Interval(
								lowerBoundary: lowerBoundaryAccessibility,
								lowerEndpoint: lowerEndpoint,
								upperEndpoint: upperEndpoint,
								upperBoundary: upperBoundaryAccessibility
							),
							Interval(
								lowerBoundary: lowerBoundaryAccessibility,
								lowerEndpoint: lowerEndpoint,
								upperEndpoint: upperEndpoint,
								upperBoundary: upperBoundaryAccessibility,
								inInverseStridingDirection: false
							),
							"`Interval` fails to initialise correctly with default parameter values."
						)
						
					}
				}
			}
		}
		
	}
	
	///	Checks that `Interval`'s bounded interval initialiser works as intended.
	func testBoundedIntervalInitialiser() {
		
		boundaryAvailabilities.forEach { lowerBoundaryAvailability in
			boundaryAvailabilities.forEach { upperBoundaryAvailability in
				whetherIntervalShouldBeOrderedDescendingly.forEach { intervalShouldBeOrderedDescendingly in
					
					//	MARK: Initialise with Explicit Parameter Values
					
					XCTAssertEqual(
						Interval(
							from: lowerBoundedEndpointValue, lowerBoundaryAvailability,
							to: upperBoundedEndpointValue, upperBoundaryAvailability,
							inInverseStridingDirection: intervalShouldBeOrderedDescendingly
						),
						Interval(
							lowerBoundary: IntervalBoundaryAccessibility(availability: lowerBoundaryAvailability),
							lowerEndpoint: lowerBoundedEndpoint,
							upperEndpoint: upperBoundedEndpoint,
							upperBoundary: IntervalBoundaryAccessibility(availability: upperBoundaryAvailability),
							inInverseStridingDirection: intervalShouldBeOrderedDescendingly
						),
						"`Interval`'s initialiser for bounded intervals fails to initialise correctly."
					)
					
				}
				
				//	MARK: Initialise with Default Parameter Values
				
				XCTAssertEqual(
					Interval(
						from: lowerBoundedEndpointValue, lowerBoundaryAvailability,
						to: upperBoundedEndpointValue, upperBoundaryAvailability
					),
					Interval(
						lowerBoundary: IntervalBoundaryAccessibility(availability: lowerBoundaryAvailability),
						lowerEndpoint: lowerBoundedEndpoint,
						upperEndpoint: upperBoundedEndpoint,
						upperBoundary: IntervalBoundaryAccessibility(availability: upperBoundaryAvailability)
					),
					"`Interval`'s initialiser for bounded intervals fails to initialise correctly with default parameter values."
				)
				
			}
		}
		
	}
	
	///	Checks that `Interval`'s interval-with-symmetric-boundary-conditions initialiser works as intended.
	func testIntervalWithSymmetricBoundaryConditionsInitialiser() {
		
		boundaryAvailabilities.forEach { boundaryAvailability in
			whetherIntervalShouldBeOrderedDescendingly.forEach { intervalShouldBeOrderedDescendingly in
				
				//	MARK: Initialise with Explicit Parameter Values
				
				XCTAssertEqual(
					Interval(
						from: lowerBoundedEndpointValue, to: upperBoundedEndpointValue, boundaryAvailability,
						inInverseStridingDirection: intervalShouldBeOrderedDescendingly
					),
					Interval(
						lowerBoundary: IntervalBoundaryAccessibility(availability: boundaryAvailability),
						lowerEndpoint: lowerBoundedEndpoint,
						upperEndpoint: upperBoundedEndpoint,
						upperBoundary: IntervalBoundaryAccessibility(availability: boundaryAvailability),
						inInverseStridingDirection: intervalShouldBeOrderedDescendingly
					),
					"`Interval`'s initialiser for intervals with symmetric boundary conditions fails to initialise correctly."
				)
				
			}
			
			//	MARK: Initialise with Default Parameter Values
			
			XCTAssertEqual(
				Interval(from: lowerBoundedEndpointValue, to: upperBoundedEndpointValue, boundaryAvailability),
				Interval(
					lowerBoundary: IntervalBoundaryAccessibility(availability: boundaryAvailability),
					lowerEndpoint: lowerBoundedEndpoint,
					upperEndpoint: upperBoundedEndpoint,
					upperBoundary: IntervalBoundaryAccessibility(availability: boundaryAvailability)
				),
				"`Interval`'s initialiser for intervals with symmetric boundary conditions fails to initialise correctly with default parameter values."
			)
			
		}
		
	}
	
	///	Checks that `Interval`'s lower-bounded upper-unbounded interval initialiser works as intended.
	func testLowerBoundedUpperUnboundedIntervalInitialiser() {
		
		boundaryAvailabilities.forEach { lowerBoundaryAvailability in
			whetherIntervalShouldBeOrderedDescendingly.forEach { intervalShouldBeOrderedDescendingly in
				
				//	MARK: Initialise with Explicit Parameter Values
				
				XCTAssertEqual(
					Interval(
						toUnboundedFrom: lowerBoundedEndpointValue, lowerBoundaryAvailability,
						inInverseStridingDirection: intervalShouldBeOrderedDescendingly
					),
					Interval(
						lowerBoundary: IntervalBoundaryAccessibility(availability: lowerBoundaryAvailability),
						lowerEndpoint: lowerBoundedEndpoint,
						upperEndpoint: .unbounded,
						upperBoundary: .open,
						inInverseStridingDirection: intervalShouldBeOrderedDescendingly
					),
					"`Interval`'s initialiser for lower-bounded upper-unbounded intervals fails to initialise correctly."
				)
				
			}
			
			//	MARK: Initialise with Default Parameter Values
			
			XCTAssertEqual(
				Interval(toUnboundedFrom: lowerBoundedEndpointValue, lowerBoundaryAvailability),
				Interval(
					lowerBoundary: IntervalBoundaryAccessibility(availability: lowerBoundaryAvailability),
					lowerEndpoint: lowerBoundedEndpoint,
					upperEndpoint: .unbounded,
					upperBoundary: .open
				),
				"`Interval`'s initialiser for lower-bounded upper-unbounded intervals fails to initialise correctly with default parameter values."
			)
			
		}
		
	}
	
	///	Checks that `Interval`'s lower-unbounded upper-bounded interval initialiser works as intended.
	func testLowerUnboundedUpperBoundedIntervalInitialiser() {
		
		boundaryAvailabilities.forEach { upperBoundaryAvailability in
			whetherIntervalShouldBeOrderedDescendingly.forEach { intervalShouldBeOrderedDescendingly in
				
				//	MARK: Initialise with Explicit Parameter Values
				
				XCTAssertEqual(
					Interval(
						fromUnboundedTo: upperBoundedEndpointValue, upperBoundaryAvailability,
						inInverseStridingDirection: intervalShouldBeOrderedDescendingly
					),
					Interval(
						lowerBoundary: .open,
						lowerEndpoint: .unbounded,
						upperEndpoint: upperBoundedEndpoint,
						upperBoundary: IntervalBoundaryAccessibility(availability: upperBoundaryAvailability),
						inInverseStridingDirection: intervalShouldBeOrderedDescendingly
					),
					"`Interval`'s initialiser for lower-unbounded upper-bounded intervals fails to initialise correctly."
				)
				
			}
			
			//	MARK: Initialise with Default Parameter Values
			
			XCTAssertEqual(
				Interval(fromUnboundedTo: upperBoundedEndpointValue, upperBoundaryAvailability),
				Interval(
					lowerBoundary: .open,
					lowerEndpoint: .unbounded,
					upperEndpoint: upperBoundedEndpoint,
					upperBoundary: IntervalBoundaryAccessibility(availability: upperBoundaryAvailability)
				),
				"`Interval`'s initialiser for lower-unbounded upper-bounded intervals fails to initialise correctly with default parameter values."
			)
			
		}
		
	}
	
	///	Checks that `Internal` can correctly initialise from a `ClosedRange` instance.
	func testInitialisingFromClosedRange() {
		XCTAssertEqual(
			Interval(closedRange: lowerBoundedEndpointValue...upperBoundedEndpointValue),
			lowerBoundedEndpointValue≤∙≤upperBoundedEndpointValue,
			"Fails to instantiate a `\(lowerBoundedEndpointValue)≤∙≤\(upperBoundedEndpointValue)` from `\(lowerBoundedEndpointValue)...\(upperBoundedEndpointValue)`"
		)
	}
	
	///	Checks that `Internal` can correctly initialise from a `Range` instance.
	func testInitialisingFromRange() {
		XCTAssertEqual(
			Interval(range: lowerBoundedEndpointValue..<upperBoundedEndpointValue),
			lowerBoundedEndpointValue≤∙<upperBoundedEndpointValue,
			"Fails to instantiate a `\(lowerBoundedEndpointValue)≤∙<\(upperBoundedEndpointValue)` from `\(lowerBoundedEndpointValue)...\(upperBoundedEndpointValue)`"
		)
	}
	
	///	Checks that `Internal` can correctly initialise from a `PartialRangeFrom` instance.
	func testInitialisingFromLowerBoundedPartialRange() {
		XCTAssertEqual(
			Interval(lowerBoundedPartialRange: lowerBoundedEndpointValue...),
			lowerBoundedEndpointValue≤∙∙,
			"Fails to instantiate a `\(lowerBoundedEndpointValue)≤∙∙` from `\(lowerBoundedEndpointValue)...`"
		)
	}
	
	///	Checks that `Internal` can correctly initialise from a `PartialRangeThrough` instance.
	func testInitialisingFromUpperBoundedAndClosedPartialRange() {
		XCTAssertEqual(
			Interval(upperBoundedAndClosedPartialRange: ...upperBoundedEndpointValue),
			∙∙≤upperBoundedEndpointValue,
			"Fails to instantiate a `∙∙≤\(upperBoundedEndpointValue)` from `...\(upperBoundedEndpointValue)`"
		)
	}
	
	///	Checks that `Internal` can correctly initialise from a `PartialRangeTo` instance.
	func testInitialisingFromUpperBoundedAndOpenPartialRange() {
		XCTAssertEqual(
			Interval(upperBoundedAndOpenPartialRange: ..<upperBoundedEndpointValue),
			∙∙<upperBoundedEndpointValue,
			"Fails to instantiate a `∙∙<\(upperBoundedEndpointValue)` from `..<\(upperBoundedEndpointValue)`"
		)
	}
	
	///	Checks that `Internal` can correctly initialise from a `UnboundedRange` instance.
	func testInitialisingFromUnboundedRange() {
		XCTAssertEqual(
			Interval<Int>(unboundedRange: ...),
			Interval<Int>.unbounded,
			"Fails to instantiate an unbounded real interval from `...`"
		)
	}
	
	///	Checks that `Interval` can provide a correct unbounded interval.
	func testCorrectnessOfUnboundedInterval() {
		XCTAssertEqual(
			Interval<Int>.unbounded,
			Interval<Int>(
				lowerBoundary: .open,
				lowerEndpoint: .unbounded,
				upperEndpoint: .unbounded,
				upperBoundary: .open
			),
			"`Interval<Int>` fails to provide (-∞, ∞)."
		)
	}
	
	///	Checks that interval operators work as intended.
	func testIntervalOperators() {
		
		//	MARK: Ascending Interval operators.
		
		XCTAssertEqual(
			lowerBoundedEndpointValue≤∙≤upperBoundedEndpointValue,
			Interval(
				lowerBoundary: .closed,
				lowerEndpoint: lowerBoundedEndpoint,
				upperEndpoint: upperBoundedEndpoint,
				upperBoundary: .closed,
				inInverseStridingDirection: false
			),
			"`\(lowerBoundedEndpointValue)≤∙≤\(upperBoundedEndpointValue)` fails to initialise [\(lowerBoundedEndpointValue), \(upperBoundedEndpointValue)]."
		)
		
		XCTAssertEqual(
			lowerBoundedEndpointValue≤∙<upperBoundedEndpointValue,
			Interval(
				lowerBoundary: .closed,
				lowerEndpoint: lowerBoundedEndpoint,
				upperEndpoint: upperBoundedEndpoint,
				upperBoundary: .open,
				inInverseStridingDirection: false
			),
			"`\(lowerBoundedEndpointValue)≤∙<\(upperBoundedEndpointValue)` fails to initialise [\(lowerBoundedEndpointValue), \(upperBoundedEndpointValue))."
		)
		
		XCTAssertEqual(
			lowerBoundedEndpointValue<∙≤upperBoundedEndpointValue,
			Interval(
				lowerBoundary: .open,
				lowerEndpoint: lowerBoundedEndpoint,
				upperEndpoint: upperBoundedEndpoint,
				upperBoundary: .closed,
				inInverseStridingDirection: false
			),
			"`\(lowerBoundedEndpointValue)<∙≤\(upperBoundedEndpointValue)` fails to initialise (\(lowerBoundedEndpointValue), \(upperBoundedEndpointValue)]."
		)
		
		XCTAssertEqual(
			lowerBoundedEndpointValue<∙<upperBoundedEndpointValue,
			Interval(
				lowerBoundary: .open,
				lowerEndpoint: lowerBoundedEndpoint,
				upperEndpoint: upperBoundedEndpoint,
				upperBoundary: .open,
				inInverseStridingDirection: false
			),
			"`\(lowerBoundedEndpointValue)<∙<\(upperBoundedEndpointValue)` fails to initialise (\(lowerBoundedEndpointValue), \(upperBoundedEndpointValue))."
		)
		
		XCTAssertEqual(
			∙∙≤upperBoundedEndpointValue,
			Interval(
				lowerBoundary: .open,
				lowerEndpoint: .unbounded,
				upperEndpoint: upperBoundedEndpoint,
				upperBoundary: .closed,
				inInverseStridingDirection: false
			),
			"`∙∙≤\(upperBoundedEndpointValue)` fails to initialise (-∞, \(upperBoundedEndpointValue)]."
		)
		
		XCTAssertEqual(
			∙∙<upperBoundedEndpointValue,
			Interval(
				lowerBoundary: .open,
				lowerEndpoint: .unbounded,
				upperEndpoint: upperBoundedEndpoint,
				upperBoundary: .open,
				inInverseStridingDirection: false
			),
			"`∙∙<\(upperBoundedEndpointValue)` fails to initialise (-∞, \(upperBoundedEndpointValue))."
		)
		
		XCTAssertEqual(
			lowerBoundedEndpointValue≤∙∙,
			Interval(
				lowerBoundary: .closed,
				lowerEndpoint: lowerBoundedEndpoint,
				upperEndpoint: .unbounded,
				upperBoundary: .open,
				inInverseStridingDirection: false
			),
			"`\(lowerBoundedEndpointValue)≤∙∙` fails to initialise [\(lowerBoundedEndpointValue), ∞)."
		)
		
		XCTAssertEqual(
			lowerBoundedEndpointValue<∙∙,
			Interval(
				lowerBoundary: .open,
				lowerEndpoint: lowerBoundedEndpoint,
				upperEndpoint: .unbounded,
				upperBoundary: .open,
				inInverseStridingDirection: false
			),
			"`\(lowerBoundedEndpointValue)<∙∙` fails to initialise (\(lowerBoundedEndpointValue), ∞)."
		)
		
		//	MARK: Descending interval operators.
		
		XCTAssertEqual(
			upperBoundedEndpointValue≥∙≥lowerBoundedEndpointValue,
			Interval(
				lowerBoundary: .closed,
				lowerEndpoint: lowerBoundedEndpoint,
				upperEndpoint: upperBoundedEndpoint,
				upperBoundary: .closed,
				inInverseStridingDirection: true
			),
			"`\(upperBoundedEndpointValue)≥∙≥\(lowerBoundedEndpointValue)` fails to initialise inverse [\(lowerBoundedEndpointValue), \(upperBoundedEndpointValue)]."
		)
		
		XCTAssertEqual(
			upperBoundedEndpointValue>∙≥lowerBoundedEndpointValue,
			Interval(
				lowerBoundary: .closed,
				lowerEndpoint: lowerBoundedEndpoint,
				upperEndpoint: upperBoundedEndpoint,
				upperBoundary: .open,
				inInverseStridingDirection: true
			),
			"`\(upperBoundedEndpointValue)>∙≥\(lowerBoundedEndpointValue)` fails to initialise inverse [\(lowerBoundedEndpointValue), \(upperBoundedEndpointValue))."
		)
		
		XCTAssertEqual(
			upperBoundedEndpointValue≥∙>lowerBoundedEndpointValue,
			Interval(
				lowerBoundary: .open,
				lowerEndpoint: lowerBoundedEndpoint,
				upperEndpoint: upperBoundedEndpoint,
				upperBoundary: .closed,
				inInverseStridingDirection: true
			),
			"`\(upperBoundedEndpointValue)≥∙>\(lowerBoundedEndpointValue)` fails to initialise inverse (\(lowerBoundedEndpointValue), \(upperBoundedEndpointValue)]."
		)
		
		XCTAssertEqual(
			upperBoundedEndpointValue>∙>lowerBoundedEndpointValue,
			Interval(
				lowerBoundary: .open,
				lowerEndpoint: lowerBoundedEndpoint,
				upperEndpoint: upperBoundedEndpoint,
				upperBoundary: .open,
				inInverseStridingDirection: true
			),
			"`\(upperBoundedEndpointValue)>∙>\(lowerBoundedEndpointValue)` fails to initialise inverse (\(lowerBoundedEndpointValue), \(upperBoundedEndpointValue))."
		)
		
		XCTAssertEqual(
			upperBoundedEndpointValue≥∙∙,
			Interval(
				lowerBoundary: .open,
				lowerEndpoint: .unbounded,
				upperEndpoint: upperBoundedEndpoint,
				upperBoundary: .closed,
				inInverseStridingDirection: true
			),
			"`\(upperBoundedEndpointValue)≥∙∙` fails to initialise inverse (-∞, \(upperBoundedEndpointValue)]."
		)
		
		XCTAssertEqual(
			upperBoundedEndpointValue>∙∙,
			Interval(
				lowerBoundary: .open,
				lowerEndpoint: .unbounded,
				upperEndpoint: upperBoundedEndpoint,
				upperBoundary: .open,
				inInverseStridingDirection: true
			),
			"`\(upperBoundedEndpointValue)>∙∙` fails to initialise inverse (-∞, \(upperBoundedEndpointValue))."
		)
		
		XCTAssertEqual(
			∙∙≥lowerBoundedEndpointValue,
			Interval(
				lowerBoundary: .closed,
				lowerEndpoint: lowerBoundedEndpoint,
				upperEndpoint: .unbounded,
				upperBoundary: .open,
				inInverseStridingDirection: true
			),
			"`∙∙≥\(lowerBoundedEndpointValue)` fails to initialise inverse [\(lowerBoundedEndpointValue), ∞)."
		)
		
		XCTAssertEqual(
			∙∙>lowerBoundedEndpointValue,
			Interval(
				lowerBoundary: .open,
				lowerEndpoint: lowerBoundedEndpoint,
				upperEndpoint: .unbounded,
				upperBoundary: .open,
				inInverseStridingDirection: true
			),
			"`∙∙>\(lowerBoundedEndpointValue)` fails to initialise inverse (\(lowerBoundedEndpointValue), ∞)."
		)
		
	}
	
}
