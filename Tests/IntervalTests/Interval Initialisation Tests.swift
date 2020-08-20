//
//	Interval Initialisation Tests.swift - Test cases and methods regarding instantiating an interval.
//
//	Created by Wowbagger & His Liquid Lunch on 20-08-10.
//

import XCTest
@testable import Interval

///	A group of test cases and methods regarding instantiating `Interval`.
final class IntervalInitialisationTests: XCTestCase {
	
	///	The lesser bounded endpoint value for testing initialisations.
	let lesserBoundedEndpointValue = 0
	///	The greater bounded endpoint value for testing initialisations.
	let greaterBoundedEndpointValue = 1
	///	The collection of bounded endpoint values for testing initialisations.
	var boundedEndpointValues: [Int] { [lesserBoundedEndpointValue, greaterBoundedEndpointValue] }
	
	///	The lesser bounded endpoint for testing initialisations.
	var lesserBoundedEndpoint: Interval<Int>.Endpoint { .bounded(lesserBoundedEndpointValue) }
	///	The greater bounded endpoint for testing initialisations.
	var greaterBoundedEndpoint: Interval<Int>.Endpoint { .bounded(greaterBoundedEndpointValue) }
	///	The collection of endpoints for testing initialisations.
	var endpoints: [Interval<Int>.Endpoint] { [lesserBoundedEndpoint, greaterBoundedEndpoint, .unbounded] }
	
	///	The collection of boundary accessibilities for testing initialisations.
	let boundaryAccessibilities: [IntervalBoundaryAccessibility] = [.closed, .open]
	///	The collection of boundary availabilities for testing initialisations.
	let boundaryAvailabilities: [IntervalBoundaryAvailability] = [.inclusive, .exclusive]
	
	///	The collection of interval striding directions for testing initialisations.
	let whetherIntervalShouldBeOrderedDescendingly: [Bool] = [true, false]
	
	///	Checks that `Interval`'s primary initialiser's default parameters works as intended.
	func testPrimaryInitialiser() {
		
		endpoints.forEach { lowerEndpoint in
			endpoints.forEach { upperEndpoint in
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
		
		boundedEndpointValues.forEach { lowerBoundedEndpointValue in
			boundedEndpointValues.forEach { upperBoundedEndpointValue in
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
									lowerEndpoint: .bounded(lowerBoundedEndpointValue),
									upperEndpoint: .bounded(upperBoundedEndpointValue),
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
								lowerEndpoint: .bounded(lowerBoundedEndpointValue),
								upperEndpoint: .bounded(upperBoundedEndpointValue),
								upperBoundary: IntervalBoundaryAccessibility(availability: upperBoundaryAvailability)
							),
							"`Interval`'s initialiser for bounded intervals fails to initialise correctly with default parameter values."
						)
						
					}
				}
			}
		}
				
	}
	
	///	Checks that `Interval`'s interval-with-symmetric-boundary-conditions initialiser works as intended.
	func testIntervalWithSymmetricBoundaryConditionsInitialiser() {
		
		boundedEndpointValues.forEach { lowerBoundedEndpointValue in
			boundedEndpointValues.forEach { upperBoundedEndpointValue in
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
								lowerEndpoint: .bounded(lowerBoundedEndpointValue),
								upperEndpoint: .bounded(upperBoundedEndpointValue),
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
							lowerEndpoint: .bounded(lowerBoundedEndpointValue),
							upperEndpoint: .bounded(upperBoundedEndpointValue),
							upperBoundary: IntervalBoundaryAccessibility(availability: boundaryAvailability)
						),
						"`Interval`'s initialiser for intervals with symmetric boundary conditions fails to initialise correctly with default parameter values."
					)
					
				}
			}
		}
		
	}
	
	///	Checks that `Interval`'s lower-bounded upper-unbounded interval initialiser works as intended.
	func testLowerBoundedUpperUnboundedIntervalInitialiser() {
		
		boundaryAvailabilities.forEach { lowerBoundaryAvailability in
			whetherIntervalShouldBeOrderedDescendingly.forEach { intervalShouldBeOrderedDescendingly in
				
				//	MARK: Initialise with Explicit Parameter Values
				
				XCTAssertEqual(
					Interval(
						toUnboundedFrom: lesserBoundedEndpointValue, lowerBoundaryAvailability,
						inInverseStridingDirection: intervalShouldBeOrderedDescendingly
					),
					Interval(
						lowerBoundary: IntervalBoundaryAccessibility(availability: lowerBoundaryAvailability),
						lowerEndpoint: lesserBoundedEndpoint,
						upperEndpoint: .unbounded,
						upperBoundary: .open,
						inInverseStridingDirection: intervalShouldBeOrderedDescendingly
					),
					"`Interval`'s initialiser for lower-bounded upper-unbounded intervals fails to initialise correctly."
				)
				
			}
			
			//	MARK: Initialise with Default Parameter Values
			
			XCTAssertEqual(
				Interval(toUnboundedFrom: lesserBoundedEndpointValue, lowerBoundaryAvailability),
				Interval(
					lowerBoundary: IntervalBoundaryAccessibility(availability: lowerBoundaryAvailability),
					lowerEndpoint: lesserBoundedEndpoint,
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
						fromUnboundedTo: greaterBoundedEndpointValue, upperBoundaryAvailability,
						inInverseStridingDirection: intervalShouldBeOrderedDescendingly
					),
					Interval(
						lowerBoundary: .open,
						lowerEndpoint: .unbounded,
						upperEndpoint: greaterBoundedEndpoint,
						upperBoundary: IntervalBoundaryAccessibility(availability: upperBoundaryAvailability),
						inInverseStridingDirection: intervalShouldBeOrderedDescendingly
					),
					"`Interval`'s initialiser for lower-unbounded upper-bounded intervals fails to initialise correctly."
				)
				
			}
			
			//	MARK: Initialise with Default Parameter Values
			
			XCTAssertEqual(
				Interval(fromUnboundedTo: greaterBoundedEndpointValue, upperBoundaryAvailability),
				Interval(
					lowerBoundary: .open,
					lowerEndpoint: .unbounded,
					upperEndpoint: greaterBoundedEndpoint,
					upperBoundary: IntervalBoundaryAccessibility(availability: upperBoundaryAvailability)
				),
				"`Interval`'s initialiser for lower-unbounded upper-bounded intervals fails to initialise correctly with default parameter values."
			)
			
		}
		
	}
	
	///	Checks that `Internal` can correctly initialise from a `ClosedRange` instance.
	func testInitialisingFromClosedRange() {
		XCTAssertEqual(
			Interval(closedRange: lesserBoundedEndpointValue...greaterBoundedEndpointValue),
			lesserBoundedEndpointValue≤∙≤greaterBoundedEndpointValue,
			"Fails to instantiate a `\(lesserBoundedEndpointValue)≤∙≤\(greaterBoundedEndpointValue)` from `\(lesserBoundedEndpointValue)...\(greaterBoundedEndpointValue)`"
		)
	}
	
	///	Checks that `Internal` can correctly initialise from a `Range` instance.
	func testInitialisingFromRange() {
		XCTAssertEqual(
			Interval(range: lesserBoundedEndpointValue..<greaterBoundedEndpointValue),
			lesserBoundedEndpointValue≤∙<greaterBoundedEndpointValue,
			"Fails to instantiate a `\(lesserBoundedEndpointValue)≤∙<\(greaterBoundedEndpointValue)` from `\(lesserBoundedEndpointValue)...\(greaterBoundedEndpointValue)`"
		)
	}
	
	///	Checks that `Internal` can correctly initialise from a `PartialRangeFrom` instance.
	func testInitialisingFromLowerBoundedPartialRange() {
		XCTAssertEqual(
			Interval(lowerBoundedPartialRange: lesserBoundedEndpointValue...),
			lesserBoundedEndpointValue≤∙∙,
			"Fails to instantiate a `\(lesserBoundedEndpointValue)≤∙∙` from `\(lesserBoundedEndpointValue)...`"
		)
	}
	
	///	Checks that `Internal` can correctly initialise from a `PartialRangeThrough` instance.
	func testInitialisingFromUpperBoundedAndClosedPartialRange() {
		XCTAssertEqual(
			Interval(upperBoundedAndClosedPartialRange: ...greaterBoundedEndpointValue),
			∙∙≤greaterBoundedEndpointValue,
			"Fails to instantiate a `∙∙≤\(greaterBoundedEndpointValue)` from `...\(greaterBoundedEndpointValue)`"
		)
	}
	
	///	Checks that `Internal` can correctly initialise from a `PartialRangeTo` instance.
	func testInitialisingFromUpperBoundedAndOpenPartialRange() {
		XCTAssertEqual(
			Interval(upperBoundedAndOpenPartialRange: ..<greaterBoundedEndpointValue),
			∙∙<greaterBoundedEndpointValue,
			"Fails to instantiate a `∙∙<\(greaterBoundedEndpointValue)` from `..<\(greaterBoundedEndpointValue)`"
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
		
		boundedEndpointValues.forEach { lowerBoundedEndpointValue in
			boundedEndpointValues.forEach { upperBoundedEndpointValue in
				
				//	MARK: Ascending Interval operators.
				
				XCTAssertEqual(
					lowerBoundedEndpointValue≤∙≤upperBoundedEndpointValue,
					Interval(
						lowerBoundary: .closed,
						lowerEndpoint: .bounded(lowerBoundedEndpointValue),
						upperEndpoint: .bounded(upperBoundedEndpointValue),
						upperBoundary: .closed,
						inInverseStridingDirection: false
					),
					"`\(lowerBoundedEndpointValue)≤∙≤\(upperBoundedEndpointValue)` fails to initialise [\(lowerBoundedEndpointValue), \(upperBoundedEndpointValue)]."
				)
				
				XCTAssertEqual(
					lowerBoundedEndpointValue≤∙<upperBoundedEndpointValue,
					Interval(
						lowerBoundary: .closed,
						lowerEndpoint: .bounded(lowerBoundedEndpointValue),
						upperEndpoint: .bounded(upperBoundedEndpointValue),
						upperBoundary: .open,
						inInverseStridingDirection: false
					),
					"`\(lowerBoundedEndpointValue)≤∙<\(upperBoundedEndpointValue)` fails to initialise [\(lowerBoundedEndpointValue), \(upperBoundedEndpointValue))."
				)
				
				XCTAssertEqual(
					lowerBoundedEndpointValue<∙≤upperBoundedEndpointValue,
					Interval(
						lowerBoundary: .open,
						lowerEndpoint: .bounded(lowerBoundedEndpointValue),
						upperEndpoint: .bounded(upperBoundedEndpointValue),
						upperBoundary: .closed,
						inInverseStridingDirection: false
					),
					"`\(lowerBoundedEndpointValue)<∙≤\(upperBoundedEndpointValue)` fails to initialise (\(lowerBoundedEndpointValue), \(upperBoundedEndpointValue)]."
				)
				
				XCTAssertEqual(
					lowerBoundedEndpointValue<∙<upperBoundedEndpointValue,
					Interval(
						lowerBoundary: .open,
						lowerEndpoint: .bounded(lowerBoundedEndpointValue),
						upperEndpoint: .bounded(upperBoundedEndpointValue),
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
						upperEndpoint: .bounded(upperBoundedEndpointValue),
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
						upperEndpoint: .bounded(upperBoundedEndpointValue),
						upperBoundary: .open,
						inInverseStridingDirection: false
					),
					"`∙∙<\(upperBoundedEndpointValue)` fails to initialise (-∞, \(upperBoundedEndpointValue))."
				)
				
				XCTAssertEqual(
					lowerBoundedEndpointValue≤∙∙,
					Interval(
						lowerBoundary: .closed,
						lowerEndpoint: .bounded(lowerBoundedEndpointValue),
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
						lowerEndpoint: .bounded(lowerBoundedEndpointValue),
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
						lowerEndpoint: .bounded(lowerBoundedEndpointValue),
						upperEndpoint: .bounded(upperBoundedEndpointValue),
						upperBoundary: .closed,
						inInverseStridingDirection: true
					),
					"`\(upperBoundedEndpointValue)≥∙≥\(lowerBoundedEndpointValue)` fails to initialise inverse [\(lowerBoundedEndpointValue), \(upperBoundedEndpointValue)]."
				)
				
				XCTAssertEqual(
					upperBoundedEndpointValue>∙≥lowerBoundedEndpointValue,
					Interval(
						lowerBoundary: .closed,
						lowerEndpoint: .bounded(lowerBoundedEndpointValue),
						upperEndpoint: .bounded(upperBoundedEndpointValue),
						upperBoundary: .open,
						inInverseStridingDirection: true
					),
					"`\(upperBoundedEndpointValue)>∙≥\(lowerBoundedEndpointValue)` fails to initialise inverse [\(lowerBoundedEndpointValue), \(upperBoundedEndpointValue))."
				)
				
				XCTAssertEqual(
					upperBoundedEndpointValue≥∙>lowerBoundedEndpointValue,
					Interval(
						lowerBoundary: .open,
						lowerEndpoint: .bounded(lowerBoundedEndpointValue),
						upperEndpoint: .bounded(upperBoundedEndpointValue),
						upperBoundary: .closed,
						inInverseStridingDirection: true
					),
					"`\(upperBoundedEndpointValue)≥∙>\(lowerBoundedEndpointValue)` fails to initialise inverse (\(lowerBoundedEndpointValue), \(upperBoundedEndpointValue)]."
				)
				
				XCTAssertEqual(
					upperBoundedEndpointValue>∙>lowerBoundedEndpointValue,
					Interval(
						lowerBoundary: .open,
						lowerEndpoint: .bounded(lowerBoundedEndpointValue),
						upperEndpoint: .bounded(upperBoundedEndpointValue),
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
						upperEndpoint: .bounded(upperBoundedEndpointValue),
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
						upperEndpoint: .bounded(upperBoundedEndpointValue),
						upperBoundary: .open,
						inInverseStridingDirection: true
					),
					"`\(upperBoundedEndpointValue)>∙∙` fails to initialise inverse (-∞, \(upperBoundedEndpointValue))."
				)
				
				XCTAssertEqual(
					∙∙≥lowerBoundedEndpointValue,
					Interval(
						lowerBoundary: .closed,
						lowerEndpoint: .bounded(lowerBoundedEndpointValue),
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
						lowerEndpoint: .bounded(lowerBoundedEndpointValue),
						upperEndpoint: .unbounded,
						upperBoundary: .open,
						inInverseStridingDirection: true
					),
					"`∙∙>\(lowerBoundedEndpointValue)` fails to initialise inverse (\(lowerBoundedEndpointValue), ∞)."
				)
				
			}
		}
		
	}
		
}
