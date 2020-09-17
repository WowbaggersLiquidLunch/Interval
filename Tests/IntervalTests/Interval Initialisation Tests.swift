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
	func testOGInitialiser() {
		
		endpoints.forEach { lowerEndpoint in
			endpoints.forEach { upperEndpoint in
				boundaryAccessibilities.forEach { lowerBoundaryAccessibility in
					boundaryAccessibilities.forEach { upperBoundaryAccessibility in
						
						let interval1 = Interval(
							lowerBoundary: lowerBoundaryAccessibility,
							lowerEndpoint: lowerEndpoint,
							upperEndpoint: upperEndpoint,
							upperBoundary: upperBoundaryAccessibility
						)
						let interval2 = Interval(
							lowerBoundary: lowerBoundaryAccessibility,
							lowerEndpoint: lowerEndpoint,
							upperEndpoint: upperEndpoint,
							upperBoundary: upperBoundaryAccessibility,
							inInverseStridingDirection: false
						)
						
						compareIntervals(interval1, interval2, failureMessage: "`Interval` fails to initialise correctly with default parameter values.")
						
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
							
							let interval1 = Interval(
								from: lowerBoundedEndpointValue, lowerBoundaryAvailability,
								to: upperBoundedEndpointValue, upperBoundaryAvailability,
								inInverseStridingDirection: intervalShouldBeOrderedDescendingly
							)
							let interval2 = Interval(
								lowerBoundary: IntervalBoundaryAccessibility(availability: lowerBoundaryAvailability),
								lowerEndpoint: .bounded(lowerBoundedEndpointValue),
								upperEndpoint: .bounded(upperBoundedEndpointValue),
								upperBoundary: IntervalBoundaryAccessibility(availability: upperBoundaryAvailability),
								inInverseStridingDirection: intervalShouldBeOrderedDescendingly
							)
							
							compareIntervals(interval1, interval2, failureMessage: "`Interval`'s initialiser for bounded intervals fails to initialise correctly.")
							
						}
						
						//	MARK: Initialise with Default Parameter Values
						
						let interval3 = Interval(
							from: lowerBoundedEndpointValue, lowerBoundaryAvailability,
							to: upperBoundedEndpointValue, upperBoundaryAvailability
						)
						let interval4 = Interval(
							lowerBoundary: IntervalBoundaryAccessibility(availability: lowerBoundaryAvailability),
							lowerEndpoint: .bounded(lowerBoundedEndpointValue),
							upperEndpoint: .bounded(upperBoundedEndpointValue),
							upperBoundary: IntervalBoundaryAccessibility(availability: upperBoundaryAvailability),
							inInverseStridingDirection: false
						)
						
						compareIntervals(interval3, interval4, failureMessage: "`Interval`'s initialiser for bounded intervals fails to initialise correctly with default parameter values.")
						
					}
				}
			}
		}
				
	}
	
	///	Checks that `Interval`'s interval-with-symmetric-boundaries initialiser works as intended.
	func testIntervalWithSymmetricBoundariesInitialiser() {
		
		boundedEndpointValues.forEach { lowerBoundedEndpointValue in
			boundedEndpointValues.forEach { upperBoundedEndpointValue in
				boundaryAvailabilities.forEach { boundaryAvailability in
					whetherIntervalShouldBeOrderedDescendingly.forEach { intervalShouldBeOrderedDescendingly in
						
						//	MARK: Initialise with Explicit Parameter Values
						
						let interval1 = Interval(
							from: lowerBoundedEndpointValue, to: upperBoundedEndpointValue, boundaryAvailability,
							inInverseStridingDirection: intervalShouldBeOrderedDescendingly
						)
						let interval2 = Interval(
							lowerBoundary: IntervalBoundaryAccessibility(availability: boundaryAvailability),
							lowerEndpoint: .bounded(lowerBoundedEndpointValue),
							upperEndpoint: .bounded(upperBoundedEndpointValue),
							upperBoundary: IntervalBoundaryAccessibility(availability: boundaryAvailability),
							inInverseStridingDirection: intervalShouldBeOrderedDescendingly
						)
						
						compareIntervals(interval1, interval2, failureMessage: "`Interval`'s initialiser for intervals with symmetric boundaries fails to initialise correctly.")
						
					}
					
					//	MARK: Initialise with Default Parameter Values
					
					let interval3 = Interval(from: lowerBoundedEndpointValue, to: upperBoundedEndpointValue, boundaryAvailability)
					let interval4 = Interval(
						lowerBoundary: IntervalBoundaryAccessibility(availability: boundaryAvailability),
						lowerEndpoint: .bounded(lowerBoundedEndpointValue),
						upperEndpoint: .bounded(upperBoundedEndpointValue),
						upperBoundary: IntervalBoundaryAccessibility(availability: boundaryAvailability),
						inInverseStridingDirection: false
					)
					
					compareIntervals(interval3, interval4, failureMessage: "`Interval`'s initialiser for intervals with symmetric boundaries fails to initialise correctly with default parameter values.")
					
				}
			}
		}
		
	}
	
	///	Checks that `Interval`'s lower-bounded upper-unbounded interval initialiser works as intended.
	func testLowerBoundedUpperUnboundedIntervalInitialiser() {
		
		boundaryAvailabilities.forEach { lowerBoundaryAvailability in
			whetherIntervalShouldBeOrderedDescendingly.forEach { intervalShouldBeOrderedDescendingly in
				
				//	MARK: Initialise with Explicit Parameter Values
				
				let interval1 = Interval(
					toUnboundedFrom: lesserBoundedEndpointValue, lowerBoundaryAvailability,
					inInverseStridingDirection: intervalShouldBeOrderedDescendingly
				)
				let interval2 = Interval(
					lowerBoundary: IntervalBoundaryAccessibility(availability: lowerBoundaryAvailability),
					lowerEndpoint: lesserBoundedEndpoint,
					upperEndpoint: .unbounded,
					upperBoundary: .open,
					inInverseStridingDirection: intervalShouldBeOrderedDescendingly
				)
				
				compareIntervals(interval1, interval2, failureMessage: "`Interval`'s initialiser for lower-bounded upper-unbounded intervals fails to initialise correctly.")
				
			}
			
			//	MARK: Initialise with Default Parameter Values
			
			let interval3 = Interval(toUnboundedFrom: lesserBoundedEndpointValue, lowerBoundaryAvailability)
			let interval4 = Interval(
				lowerBoundary: IntervalBoundaryAccessibility(availability: lowerBoundaryAvailability),
				lowerEndpoint: lesserBoundedEndpoint,
				upperEndpoint: .unbounded,
				upperBoundary: .open,
				inInverseStridingDirection: false
			)
			
			compareIntervals(interval3, interval4, failureMessage: "`Interval`'s initialiser for lower-bounded upper-unbounded intervals fails to initialise correctly with default parameter values.")
			
		}
		
	}
	
	///	Checks that `Interval`'s lower-unbounded upper-bounded interval initialiser works as intended.
	func testLowerUnboundedUpperBoundedIntervalInitialiser() {
		
		boundaryAvailabilities.forEach { upperBoundaryAvailability in
			whetherIntervalShouldBeOrderedDescendingly.forEach { intervalShouldBeOrderedDescendingly in
				
				//	MARK: Initialise with Explicit Parameter Values
				
				let interval1 = Interval(
					fromUnboundedTo: greaterBoundedEndpointValue, upperBoundaryAvailability,
					inInverseStridingDirection: intervalShouldBeOrderedDescendingly
				)
				let interval2 = Interval(
					lowerBoundary: .open,
					lowerEndpoint: .unbounded,
					upperEndpoint: greaterBoundedEndpoint,
					upperBoundary: IntervalBoundaryAccessibility(availability: upperBoundaryAvailability),
					inInverseStridingDirection: intervalShouldBeOrderedDescendingly
				)
				
				compareIntervals(interval1, interval2, failureMessage: "`Interval`'s initialiser for lower-unbounded upper-bounded intervals fails to initialise correctly.")
				
			}
			
			//	MARK: Initialise with Default Parameter Values
			
			let interval3 = Interval(fromUnboundedTo: greaterBoundedEndpointValue, upperBoundaryAvailability)
			let interval4 = Interval(
				lowerBoundary: .open,
				lowerEndpoint: .unbounded,
				upperEndpoint: greaterBoundedEndpoint,
				upperBoundary: IntervalBoundaryAccessibility(availability: upperBoundaryAvailability)
			)
			
			compareIntervals(interval3, interval4, failureMessage: "`Interval`'s initialiser for lower-unbounded upper-bounded intervals fails to initialise correctly with default parameter values.")
			
		}
		
	}
	
	///	Checks that `Internal` can correctly initialise from a `ClosedRange` instance.
	func testInitialisingFromClosedRange() {
		compareIntervals(
			Interval(closedRange: lesserBoundedEndpointValue...greaterBoundedEndpointValue),
			lesserBoundedEndpointValue≤∙≤greaterBoundedEndpointValue,
			failureMessage: "Fails to instantiate a `\(lesserBoundedEndpointValue)≤∙≤\(greaterBoundedEndpointValue)` from `\(lesserBoundedEndpointValue)...\(greaterBoundedEndpointValue)`"
		)
	}
	
	///	Checks that `Internal` can correctly initialise from a `Range` instance.
	func testInitialisingFromRange() {
		compareIntervals(
			Interval(range: lesserBoundedEndpointValue..<greaterBoundedEndpointValue),
			lesserBoundedEndpointValue≤∙<greaterBoundedEndpointValue,
			failureMessage: "Fails to instantiate a `\(lesserBoundedEndpointValue)≤∙<\(greaterBoundedEndpointValue)` from `\(lesserBoundedEndpointValue)...\(greaterBoundedEndpointValue)`"
		)
	}
	
	///	Checks that `Internal` can correctly initialise from a `PartialRangeFrom` instance.
	func testInitialisingFromLowerBoundedPartialRange() {
		compareIntervals(
			Interval(lowerBoundedPartialRange: lesserBoundedEndpointValue...),
			lesserBoundedEndpointValue≤∙∙,
			failureMessage: "Fails to instantiate a `\(lesserBoundedEndpointValue)≤∙∙` from `\(lesserBoundedEndpointValue)...`"
		)
	}
	
	///	Checks that `Internal` can correctly initialise from a `PartialRangeThrough` instance.
	func testInitialisingFromUpperBoundedAndClosedPartialRange() {
		compareIntervals(
			Interval(upperBoundedAndClosedPartialRange: ...greaterBoundedEndpointValue),
			∙∙≤greaterBoundedEndpointValue,
			failureMessage: "Fails to instantiate a `∙∙≤\(greaterBoundedEndpointValue)` from `...\(greaterBoundedEndpointValue)`"
		)
	}
	
	///	Checks that `Internal` can correctly initialise from a `PartialRangeTo` instance.
	func testInitialisingFromUpperBoundedAndOpenPartialRange() {
		compareIntervals(
			Interval(upperBoundedAndOpenPartialRange: ..<greaterBoundedEndpointValue),
			∙∙<greaterBoundedEndpointValue,
			failureMessage: "Fails to instantiate a `∙∙<\(greaterBoundedEndpointValue)` from `..<\(greaterBoundedEndpointValue)`"
		)
	}
	
	///	Checks that `Internal` can correctly initialise from a `UnboundedRange` instance.
	func testInitialisingFromUnboundedRange() {
		compareIntervals(
			Interval<Int>(unboundedRange: ...),
			Interval<Int>.unbounded,
			failureMessage: "Fails to instantiate an unbounded real interval from `...`"
		)
	}
	
	///	Checks that `Interval` can provide a correct unbounded interval.
	func testInitialisingUnboundedInterval() {
		compareIntervals(
			Interval<Int>.unbounded,
			Interval<Int>(
				lowerBoundary: .open,
				lowerEndpoint: .unbounded,
				upperEndpoint: .unbounded,
				upperBoundary: .open
			),
			failureMessage: "`Interval<Int>` fails to provide (-∞, ∞)."
		)
	}
	
	///	Checks that each of the tested intervals has a correct interior.
	func testInitialisingInterior() {
		
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
							
							let intervalInterior = Interval(
								lowerBoundary: .open,
								lowerEndpoint: lowerEndpoint,
								upperEndpoint: upperEndpoint,
								upperBoundary: .open,
								inInverseStridingDirection: intervalShouldBeOrderedDescendingly
							)
							
							compareIntervals(
								interval.interior,
								intervalInterior,
								failureMessage: "Interval \(interval)'s interior fails to evaluate to \(intervalInterior)."
							)
							
						}
					}
				}
			}
		}
		
	}
	
	///	Checks that each of the tested intervals has a correct closure.
	func testInitialisingClosure() {
		
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
							
							let intervalClosure = Interval(
								lowerBoundary: .closed,
								lowerEndpoint: lowerEndpoint,
								upperEndpoint: upperEndpoint,
								upperBoundary: .closed,
								inInverseStridingDirection: intervalShouldBeOrderedDescendingly
							)
							
							compareIntervals(
								interval.closure,
								intervalClosure,
								failureMessage: "Interval \(interval)'s closure fails to evaluate to \(intervalClosure)."
							)
							
						}
					}
				}
			}
		}
		
	}
	
	///	Checks that `reversed()` creates a copy of the interval with its iterating direction reversed.
	func testInitialisingIntervalWithReversedIteratingDirection() {
		
		///	Pairs of interval-forming operators that create bounded intervals.
		///
		///	Each pair differ only in the iterating direction of the intervals they create.
		let boundedIntervalFormationOperatorPairs: [(formAscendingInterval: (Int, Int) -> Interval<Int>, formDescendingInterval: (Int, Int) -> Interval<Int>)] = [
			(≤∙≤, ≥∙≥),
			(≤∙<, >∙≥),
			(<∙≤, ≥∙>),
			(<∙<, >∙>)
		]
		
		///	Pairs of interval-forming operators that create bounded intervals.
		///
		///	Each pair differ only in the iterating direction of the intervals they create.
		let halfUnboundedIntervalFormationOperatorPairs: [(formAscendingInterval: (Int) -> Interval<Int>, formDescendingInterval: (Int) -> Interval<Int>)] = [
			(∙∙≤, ≥∙∙),
			(∙∙<, >∙∙),
			(≤∙∙, ∙∙≥),
			(<∙∙, ∙∙>)
		]
		
		boundedEndpointValues.forEach { lowerBoundedEndpointValue in
			boundedEndpointValues.forEach { upperBoundedEndpointValue in
				
				boundedIntervalFormationOperatorPairs.forEach { formAscendingInterval, formDescendingInterval in
					
					let ascendinglyIteratedInterval = formAscendingInterval(lowerBoundedEndpointValue, upperBoundedEndpointValue)
					let descendinglyIteratedInterval = formDescendingInterval(upperBoundedEndpointValue, lowerBoundedEndpointValue)
					
					compareIntervals(
						ascendinglyIteratedInterval.reversed(),
						descendinglyIteratedInterval,
						failureMessage: "Ascendingly iterated interval \(ascendinglyIteratedInterval) fails to create a copy with reversed iterating direction \(descendinglyIteratedInterval)."
					)
					compareIntervals(
						descendinglyIteratedInterval.reversed(),
						ascendinglyIteratedInterval,
						failureMessage: "Descendingly iterated interval \(descendinglyIteratedInterval) fails to create a copy with reversed iterating direction \(ascendinglyIteratedInterval)."
					)
					
				}
				
			}
			
			halfUnboundedIntervalFormationOperatorPairs.forEach { formAscendingInterval, formDescendingInterval in
				
				let ascendinglyIteratedInterval = formAscendingInterval(lowerBoundedEndpointValue)
				let descendinglyIteratedInterval = formDescendingInterval(lowerBoundedEndpointValue)
				
				compareIntervals(
					ascendinglyIteratedInterval.reversed(),
					descendinglyIteratedInterval,
					failureMessage: "Ascendingly iterated interval \(ascendinglyIteratedInterval) fails to create a copy with reversed iterating direction \(descendinglyIteratedInterval)."
				)
				compareIntervals(
					descendinglyIteratedInterval.reversed(),
					ascendinglyIteratedInterval,
					failureMessage: "Descendingly iterated interval \(descendinglyIteratedInterval) fails to create a copy with reversed iterating direction \(ascendinglyIteratedInterval)."
				)
				
			}
			
		}
		
	}
	
	///	Checks that interval-forming operators work as intended.
	func testIntervalFormingOperators() {
		
		boundedEndpointValues.forEach { lowerBoundedEndpointValue in
			boundedEndpointValues.forEach { upperBoundedEndpointValue in
				
				//	MARK: Ascending Interval-Forming Operators
				
				compareIntervals(
					lowerBoundedEndpointValue≤∙≤upperBoundedEndpointValue,
					Interval(
						lowerBoundary: .closed,
						lowerEndpoint: .bounded(lowerBoundedEndpointValue),
						upperEndpoint: .bounded(upperBoundedEndpointValue),
						upperBoundary: .closed,
						inInverseStridingDirection: false
					),
					failureMessage: "`\(lowerBoundedEndpointValue)≤∙≤\(upperBoundedEndpointValue)` fails to initialise [\(lowerBoundedEndpointValue), \(upperBoundedEndpointValue)]."
				)
				
				compareIntervals(
					lowerBoundedEndpointValue≤∙<upperBoundedEndpointValue,
					Interval(
						lowerBoundary: .closed,
						lowerEndpoint: .bounded(lowerBoundedEndpointValue),
						upperEndpoint: .bounded(upperBoundedEndpointValue),
						upperBoundary: .open,
						inInverseStridingDirection: false
					),
					failureMessage: "`\(lowerBoundedEndpointValue)≤∙<\(upperBoundedEndpointValue)` fails to initialise [\(lowerBoundedEndpointValue), \(upperBoundedEndpointValue))."
				)
				
				compareIntervals(
					lowerBoundedEndpointValue<∙≤upperBoundedEndpointValue,
					Interval(
						lowerBoundary: .open,
						lowerEndpoint: .bounded(lowerBoundedEndpointValue),
						upperEndpoint: .bounded(upperBoundedEndpointValue),
						upperBoundary: .closed,
						inInverseStridingDirection: false
					),
					failureMessage: "`\(lowerBoundedEndpointValue)<∙≤\(upperBoundedEndpointValue)` fails to initialise (\(lowerBoundedEndpointValue), \(upperBoundedEndpointValue)]."
				)
				
				compareIntervals(
					lowerBoundedEndpointValue<∙<upperBoundedEndpointValue,
					Interval(
						lowerBoundary: .open,
						lowerEndpoint: .bounded(lowerBoundedEndpointValue),
						upperEndpoint: .bounded(upperBoundedEndpointValue),
						upperBoundary: .open,
						inInverseStridingDirection: false
					),
					failureMessage: "`\(lowerBoundedEndpointValue)<∙<\(upperBoundedEndpointValue)` fails to initialise (\(lowerBoundedEndpointValue), \(upperBoundedEndpointValue))."
				)
				
				compareIntervals(
					∙∙≤upperBoundedEndpointValue,
					Interval(
						lowerBoundary: .open,
						lowerEndpoint: .unbounded,
						upperEndpoint: .bounded(upperBoundedEndpointValue),
						upperBoundary: .closed,
						inInverseStridingDirection: false
					),
					failureMessage: "`∙∙≤\(upperBoundedEndpointValue)` fails to initialise (-∞, \(upperBoundedEndpointValue)]."
				)
				
				compareIntervals(
					∙∙<upperBoundedEndpointValue,
					Interval(
						lowerBoundary: .open,
						lowerEndpoint: .unbounded,
						upperEndpoint: .bounded(upperBoundedEndpointValue),
						upperBoundary: .open,
						inInverseStridingDirection: false
					),
					failureMessage: "`∙∙<\(upperBoundedEndpointValue)` fails to initialise (-∞, \(upperBoundedEndpointValue))."
				)
				
				compareIntervals(
					lowerBoundedEndpointValue≤∙∙,
					Interval(
						lowerBoundary: .closed,
						lowerEndpoint: .bounded(lowerBoundedEndpointValue),
						upperEndpoint: .unbounded,
						upperBoundary: .open,
						inInverseStridingDirection: false
					),
					failureMessage: "`\(lowerBoundedEndpointValue)≤∙∙` fails to initialise [\(lowerBoundedEndpointValue), ∞)."
				)
				
				compareIntervals(
					lowerBoundedEndpointValue<∙∙,
					Interval(
						lowerBoundary: .open,
						lowerEndpoint: .bounded(lowerBoundedEndpointValue),
						upperEndpoint: .unbounded,
						upperBoundary: .open,
						inInverseStridingDirection: false
					),
					failureMessage: "`\(lowerBoundedEndpointValue)<∙∙` fails to initialise (\(lowerBoundedEndpointValue), ∞)."
				)
				
				//	MARK: Descending Interval-Forming Operators
				
				compareIntervals(
					upperBoundedEndpointValue≥∙≥lowerBoundedEndpointValue,
					Interval(
						lowerBoundary: .closed,
						lowerEndpoint: .bounded(lowerBoundedEndpointValue),
						upperEndpoint: .bounded(upperBoundedEndpointValue),
						upperBoundary: .closed,
						inInverseStridingDirection: true
					),
					failureMessage: "`\(upperBoundedEndpointValue)≥∙≥\(lowerBoundedEndpointValue)` fails to initialise inverse [\(lowerBoundedEndpointValue), \(upperBoundedEndpointValue)]."
				)
				
				compareIntervals(
					upperBoundedEndpointValue>∙≥lowerBoundedEndpointValue,
					Interval(
						lowerBoundary: .closed,
						lowerEndpoint: .bounded(lowerBoundedEndpointValue),
						upperEndpoint: .bounded(upperBoundedEndpointValue),
						upperBoundary: .open,
						inInverseStridingDirection: true
					),
					failureMessage: "`\(upperBoundedEndpointValue)>∙≥\(lowerBoundedEndpointValue)` fails to initialise inverse [\(lowerBoundedEndpointValue), \(upperBoundedEndpointValue))."
				)
				
				compareIntervals(
					upperBoundedEndpointValue≥∙>lowerBoundedEndpointValue,
					Interval(
						lowerBoundary: .open,
						lowerEndpoint: .bounded(lowerBoundedEndpointValue),
						upperEndpoint: .bounded(upperBoundedEndpointValue),
						upperBoundary: .closed,
						inInverseStridingDirection: true
					),
					failureMessage: "`\(upperBoundedEndpointValue)≥∙>\(lowerBoundedEndpointValue)` fails to initialise inverse (\(lowerBoundedEndpointValue), \(upperBoundedEndpointValue)]."
				)
				
				compareIntervals(
					upperBoundedEndpointValue>∙>lowerBoundedEndpointValue,
					Interval(
						lowerBoundary: .open,
						lowerEndpoint: .bounded(lowerBoundedEndpointValue),
						upperEndpoint: .bounded(upperBoundedEndpointValue),
						upperBoundary: .open,
						inInverseStridingDirection: true
					),
					failureMessage: "`\(upperBoundedEndpointValue)>∙>\(lowerBoundedEndpointValue)` fails to initialise inverse (\(lowerBoundedEndpointValue), \(upperBoundedEndpointValue))."
				)
				
				compareIntervals(
					upperBoundedEndpointValue≥∙∙,
					Interval(
						lowerBoundary: .open,
						lowerEndpoint: .unbounded,
						upperEndpoint: .bounded(upperBoundedEndpointValue),
						upperBoundary: .closed,
						inInverseStridingDirection: true
					),
					failureMessage: "`\(upperBoundedEndpointValue)≥∙∙` fails to initialise inverse (-∞, \(upperBoundedEndpointValue)]."
				)
				
				compareIntervals(
					upperBoundedEndpointValue>∙∙,
					Interval(
						lowerBoundary: .open,
						lowerEndpoint: .unbounded,
						upperEndpoint: .bounded(upperBoundedEndpointValue),
						upperBoundary: .open,
						inInverseStridingDirection: true
					),
					failureMessage: "`\(upperBoundedEndpointValue)>∙∙` fails to initialise inverse (-∞, \(upperBoundedEndpointValue))."
				)
				
				compareIntervals(
					∙∙≥lowerBoundedEndpointValue,
					Interval(
						lowerBoundary: .closed,
						lowerEndpoint: .bounded(lowerBoundedEndpointValue),
						upperEndpoint: .unbounded,
						upperBoundary: .open,
						inInverseStridingDirection: true
					),
					failureMessage: "`∙∙≥\(lowerBoundedEndpointValue)` fails to initialise inverse [\(lowerBoundedEndpointValue), ∞)."
				)
				
				compareIntervals(
					∙∙>lowerBoundedEndpointValue,
					Interval(
						lowerBoundary: .open,
						lowerEndpoint: .bounded(lowerBoundedEndpointValue),
						upperEndpoint: .unbounded,
						upperBoundary: .open,
						inInverseStridingDirection: true
					),
					failureMessage: "`∙∙>\(lowerBoundedEndpointValue)` fails to initialise inverse (\(lowerBoundedEndpointValue), ∞)."
				)
				
			}
		}
		
	}
	
	///	Compares 2 intervals memberwisely.
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
