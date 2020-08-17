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
	
	///	The collection of lower-bounded endpoints for testing initialisations.
	var lowerEndpoints: [Interval<Int>.Endpoint] { [lowerBoundedEndpoint, .unbounded] }
	///	The collection of upper-bounded endpoints for testing initialisations.
	var upperEndpoints: [Interval<Int>.Endpoint] { [upperBoundedEndpoint, .unbounded] }
	
	///	The collection of boundary accessibilities for testing initialisations.
	let boundaryAccessibilities: [IntervalBoundaryAccessibility] = [.closed, .open]
	///	The collection of boundary availabilities for testing initialisations.
	let boundaryAvailabilities: [IntervalBoundaryAvailability] = [.inclusive, .exclusive]
	
	///	The collection of interval striding directions for testing initialisations.
	let whetherIntervalShouldBeOrderedDescendingly: [Bool] = [true, false]
	
	///	Checks that `Interval`'s primary initialiser works as intended.
	func testPrimaryInitialiser() {
		
		lowerEndpoints.forEach { lowerEndpoint in
			upperEndpoints.forEach { upperEndpoint in
				boundaryAccessibilities.forEach { lowerBoundaryAccessibility in
					boundaryAccessibilities.forEach { upperBoundaryAccessibility in
						whetherIntervalShouldBeOrderedDescendingly.forEach { intervalShouldBeOrderedDescendingly in
							
							//	MARK: Initialise with Explicit Parameters Values
							
							let realInterval = Interval(
								lowerBoundary: lowerBoundaryAccessibility,
								lowerEndpoint: lowerEndpoint,
								upperEndpoint: upperEndpoint,
								upperBoundary: upperBoundaryAccessibility,
								inInverseStridingDirection: intervalShouldBeOrderedDescendingly
							)
							
							if lowerBoundaryAccessibility == .closed {
								XCTAssertEqual(realInterval.lowerBoundaryAccessibility, .closed, "Fails to instantiate a lower-closed real interval.")
							} else {
								XCTAssertEqual(realInterval.lowerBoundaryAccessibility, .open, "Fails to instantiate a lower-open real interval.")
							}
							
							if upperBoundaryAccessibility == .closed {
								XCTAssertEqual(realInterval.upperBoundaryAccessibility, .closed, "Fails to instantiate an upper-closed real interval.")
							} else {
								XCTAssertEqual(realInterval.upperBoundaryAccessibility, .open, "Fails to instantiate an upper-open real interval.")
							}
							
							if lowerEndpoint == lowerBoundedEndpoint {
								XCTAssertEqual(realInterval.lowerEndpoint, lowerBoundedEndpoint, "Fails to instantiate a real interval lower-bounded by \(lowerBoundedEndpointValue).")
							} else {
								XCTAssertEqual(realInterval.lowerEndpoint, .unbounded, "Fails to instantiate a lower-unbounded real interval.")
							}
							
							if upperEndpoint == upperBoundedEndpoint {
								XCTAssertEqual(realInterval.upperEndpoint, upperBoundedEndpoint, "Fails to instantiate a real interval upper-bounded by \(upperBoundedEndpointValue).")
							} else {
								XCTAssertEqual(realInterval.upperEndpoint, .unbounded, "Fails to instantiate an upper-unbounded real interval.")
							}
							
							if intervalShouldBeOrderedDescendingly {
								XCTAssertTrue(realInterval.isInverse, "Fails to instantiate an descendingly ordered real interval.")
							} else {
								XCTAssertFalse(realInterval.isInverse, "Fails to instantiate an ascendingly ordered real interval.")
							}
							
						}
						
						//	MARK: Initialise with Default Parameters Values
						
						let realInterval = Interval(
							lowerBoundary: lowerBoundaryAccessibility,
							lowerEndpoint: lowerEndpoint,
							upperEndpoint: upperEndpoint,
							upperBoundary: upperBoundaryAccessibility
						)
						
						if lowerBoundaryAccessibility == .closed {
							XCTAssertEqual(realInterval.lowerBoundaryAccessibility, .closed, "Fails to instantiate a lower-closed real interval.")
						} else {
							XCTAssertEqual(realInterval.lowerBoundaryAccessibility, .open, "Fails to instantiate a lower-open real interval.")
						}
						
						if upperBoundaryAccessibility == .closed {
							XCTAssertEqual(realInterval.upperBoundaryAccessibility, .closed, "Fails to instantiate an upper-closed real interval.")
						} else {
							XCTAssertEqual(realInterval.upperBoundaryAccessibility, .open, "Fails to instantiate an upper-open real interval.")
						}
						
						if lowerEndpoint == lowerBoundedEndpoint {
							XCTAssertEqual(realInterval.lowerEndpoint, lowerBoundedEndpoint, "Fails to instantiate a real interval lower-bounded by \(lowerBoundedEndpointValue).")
						} else {
							XCTAssertEqual(realInterval.lowerEndpoint, .unbounded, "Fails to instantiate a lower-unbounded real interval.")
						}
						
						if upperEndpoint == upperBoundedEndpoint {
							XCTAssertEqual(realInterval.upperEndpoint, upperBoundedEndpoint, "Fails to instantiate a real interval upper-bounded by \(upperBoundedEndpointValue).")
						} else {
							XCTAssertEqual(realInterval.upperEndpoint, .unbounded, "Fails to instantiate an upper-unbounded real interval.")
						}
						
						XCTAssertFalse(realInterval.isInverse, "Fails to instantiate an ascendingly ordered real interval using the default parameter value.")
						
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
					
					//	MARK: Initialise with Explicit Parameters Values
					
					let realBoundedInterval = Interval(
						from: lowerBoundedEndpointValue, lowerBoundaryAvailability,
						to: upperBoundedEndpointValue, upperBoundaryAvailability,
						inInverseStridingDirection: intervalShouldBeOrderedDescendingly
					)
					
					if lowerBoundaryAvailability == .inclusive {
						XCTAssertEqual(realBoundedInterval.lowerBoundaryAccessibility, .closed, "Fails to instantiate a lower-closed bounded interval.")
					} else {
						XCTAssertEqual(realBoundedInterval.lowerBoundaryAccessibility, .open, "Fails to instantiate a lower-open bounded interval.")
					}
					
					if upperBoundaryAvailability == .inclusive {
						XCTAssertEqual(realBoundedInterval.upperBoundaryAccessibility, .closed, "Fails to instantiate an upper-closed bounded interval.")
					} else {
						XCTAssertEqual(realBoundedInterval.upperBoundaryAccessibility, .open, "Fails to instantiate an upper-open bounded interval.")
					}
					
					XCTAssertEqual(realBoundedInterval.lowerEndpoint, lowerBoundedEndpoint, "Fails to instantiate an interval lower-bounded by \(lowerBoundedEndpointValue).")
					XCTAssertEqual(realBoundedInterval.upperEndpoint, upperBoundedEndpoint, "Fails to instantiate an interval upper-bounded by \(upperBoundedEndpointValue).")
					
					if intervalShouldBeOrderedDescendingly {
						XCTAssertTrue(realBoundedInterval.isInverse, "Fails to instantiate an descendingly ordered bounded interval.")
					} else {
						XCTAssertFalse(realBoundedInterval.isInverse, "Fails to instantiate an ascendingly ordered bounded interval.")
					}
					
				}
				
				//	MARK: Initialise with Default Parameters Values
				
				let realBoundedInterval = Interval(
					from: lowerBoundedEndpointValue, lowerBoundaryAvailability,
					to: upperBoundedEndpointValue, upperBoundaryAvailability
				)
				
				if lowerBoundaryAvailability == .inclusive {
					XCTAssertEqual(realBoundedInterval.lowerBoundaryAccessibility, .closed, "Fails to instantiate a lower-closed bounded interval.")
				} else {
					XCTAssertEqual(realBoundedInterval.lowerBoundaryAccessibility, .open, "Fails to instantiate a lower-open bounded interval.")
				}
				
				if upperBoundaryAvailability == .inclusive {
					XCTAssertEqual(realBoundedInterval.upperBoundaryAccessibility, .closed, "Fails to instantiate an upper-closed bounded interval.")
				} else {
					XCTAssertEqual(realBoundedInterval.upperBoundaryAccessibility, .open, "Fails to instantiate an upper-open bounded interval.")
				}
				
				XCTAssertEqual(realBoundedInterval.lowerEndpoint, lowerBoundedEndpoint, "Fails to instantiate an interval lower-bounded by \(lowerBoundedEndpointValue).")
				XCTAssertEqual(realBoundedInterval.upperEndpoint, upperBoundedEndpoint, "Fails to instantiate an interval upper-bounded by \(upperBoundedEndpointValue).")
				
				XCTAssertFalse(realBoundedInterval.isInverse, "Fails to instantiate an ascendingly ordered bounded interval using the default parameter value.")
				
			}
		}
		
	}
	
	///	Checks that `Interval`'s interval-with-symmetric-boundary-conditions initialiser works as intended.
	func testIntervalWithSymmetricBoundaryConditionsInitialiser() {
		
		boundaryAvailabilities.forEach { boundaryAvailability in
			whetherIntervalShouldBeOrderedDescendingly.forEach { intervalShouldBeOrderedDescendingly in
				
				//	MARK: Initialise with Explicit Parameters Values
				
				let realIntervalWithSymmetricBoundaryConditions = Interval(
					from: lowerBoundedEndpointValue, to: upperBoundedEndpointValue, boundaryAvailability,
					inInverseStridingDirection: intervalShouldBeOrderedDescendingly
				)
				
				if boundaryAvailability == .inclusive {
					XCTAssertEqual(realIntervalWithSymmetricBoundaryConditions.lowerBoundaryAccessibility, .closed, "Fails to instantiate a lower-closed real interval with symmetric boundary conditions.")
					XCTAssertEqual(realIntervalWithSymmetricBoundaryConditions.upperBoundaryAccessibility, .closed, "Fails to instantiate an upper-closed real interval with symmetric boundary conditions.")
				} else {
					XCTAssertEqual(realIntervalWithSymmetricBoundaryConditions.lowerBoundaryAccessibility, .open, "Fails to instantiate a lower-open real interval with symmetric boundary conditions.")
					XCTAssertEqual(realIntervalWithSymmetricBoundaryConditions.upperBoundaryAccessibility, .open, "Fails to instantiate an upper-open real interval with symmetric boundary conditions.")
				}
				
				XCTAssertEqual(realIntervalWithSymmetricBoundaryConditions.lowerEndpoint, lowerBoundedEndpoint, "Fails to instantiate a real interval with symmetric boundary conditions lower-bounded by \(lowerBoundedEndpointValue).")
				XCTAssertEqual(realIntervalWithSymmetricBoundaryConditions.upperEndpoint, upperBoundedEndpoint, "Fails to instantiate a real interval with symmetric boundary conditions upper-bounded by \(upperBoundedEndpointValue).")
				
				
				if intervalShouldBeOrderedDescendingly {
					XCTAssertTrue(realIntervalWithSymmetricBoundaryConditions.isInverse, "Fails to instantiate an descendingly ordered real interval with symmetric boundary conditions.")
				} else {
					XCTAssertFalse(realIntervalWithSymmetricBoundaryConditions.isInverse, "Fails to instantiate an ascendingly ordered real interval with symmetric boundary conditions.")
				}
				
			}
			
			//	MARK: Initialise with Default Parameters Values
			
			let realIntervalWithSymmetricBoundaryConditions = Interval(from: lowerBoundedEndpointValue, to: upperBoundedEndpointValue, boundaryAvailability)
			
			if boundaryAvailability == .inclusive {
				XCTAssertEqual(realIntervalWithSymmetricBoundaryConditions.lowerBoundaryAccessibility, .closed, "Fails to instantiate a lower-closed real interval with symmetric boundary conditions.")
				XCTAssertEqual(realIntervalWithSymmetricBoundaryConditions.upperBoundaryAccessibility, .closed, "Fails to instantiate an upper-closed real interval with symmetric boundary conditions.")
			} else {
				XCTAssertEqual(realIntervalWithSymmetricBoundaryConditions.lowerBoundaryAccessibility, .open, "Fails to instantiate a lower-open real interval with symmetric boundary conditions.")
				XCTAssertEqual(realIntervalWithSymmetricBoundaryConditions.upperBoundaryAccessibility, .open, "Fails to instantiate an upper-open real interval with symmetric boundary conditions.")
			}
			
			XCTAssertEqual(realIntervalWithSymmetricBoundaryConditions.lowerEndpoint, lowerBoundedEndpoint, "Fails to instantiate a real interval with symmetric boundary conditions lower-bounded by \(lowerBoundedEndpointValue).")
			XCTAssertEqual(realIntervalWithSymmetricBoundaryConditions.upperEndpoint, upperBoundedEndpoint, "Fails to instantiate a real interval with symmetric boundary conditions upper-bounded by \(upperBoundedEndpointValue).")
			
			XCTAssertFalse(realIntervalWithSymmetricBoundaryConditions.isInverse, "Fails to instantiate an ascendingly ordered real interval with symmetric boundary conditions using the default parameter value.")
			
		}
		
	}
	
	///	Checks that `Interval`'s lower-bounded upper-unbounded interval initialiser works as intended.
	func testLowerBoundedUpperUnboundedIntervalInitialiser() {
		
		boundaryAvailabilities.forEach { boundaryAvailability in
			whetherIntervalShouldBeOrderedDescendingly.forEach { intervalShouldBeOrderedDescendingly in
				
				//	MARK: Initialise with Explicit Parameters Values
				
				let lowerBoundedUpperUnboundedRealInterval = Interval(
					toUnboundedFrom: lowerBoundedEndpointValue, boundaryAvailability,
					inInverseStridingDirection: intervalShouldBeOrderedDescendingly
				)
				
				if boundaryAvailability == .inclusive {
					XCTAssertEqual(lowerBoundedUpperUnboundedRealInterval.lowerBoundaryAccessibility, .closed, "Fails to instantiate a lower-closed upper-unbounded real interval.")
				} else {
					XCTAssertEqual(lowerBoundedUpperUnboundedRealInterval.lowerBoundaryAccessibility, .open, "Fails to instantiate a lower-open upper-unbounded real interval.")
				}
				
				XCTAssertEqual(lowerBoundedUpperUnboundedRealInterval.lowerEndpoint, lowerBoundedEndpoint, "Fails to instantiate an upper-unbounded real interval lower-bounded by \(lowerBoundedEndpointValue).")
				
				
				if intervalShouldBeOrderedDescendingly {
					XCTAssertTrue(lowerBoundedUpperUnboundedRealInterval.isInverse, "Fails to instantiate an descendingly ordered upper-unbounded real interval.")
				} else {
					XCTAssertFalse(lowerBoundedUpperUnboundedRealInterval.isInverse, "Fails to instantiate an ascendingly ordered upper-unbounded real interval.")
				}
				
			}
			
			//	MARK: Initialise with Default Parameters Values
						
			let lowerBoundedUpperUnboundedRealInterval = Interval(toUnboundedFrom: lowerBoundedEndpointValue, boundaryAvailability)
			
			if boundaryAvailability == .inclusive {
				XCTAssertEqual(lowerBoundedUpperUnboundedRealInterval.lowerBoundaryAccessibility, .closed, "Fails to instantiate a lower-closed upper-unbounded real interval.")
			} else {
				XCTAssertEqual(lowerBoundedUpperUnboundedRealInterval.lowerBoundaryAccessibility, .open, "Fails to instantiate a lower-open upper-unbounded real interval.")
			}
			
			XCTAssertEqual(lowerBoundedUpperUnboundedRealInterval.lowerEndpoint, lowerBoundedEndpoint, "Fails to instantiate an upper-unbounded real interval lower-bounded by \(lowerBoundedEndpointValue).")
			
			XCTAssertFalse(lowerBoundedUpperUnboundedRealInterval.isInverse, "Fails to instantiate an ascendingly ordered upper-unbounded real interval using the default parameter value.")
			
		}
		
	}
	
	///	Checks that `Interval`'s lower-unbounded upper-bounded interval initialiser works as intended.
	func testLowerUnboundedUpperBoundedIntervalInitialiser() {
		
		boundaryAvailabilities.forEach { boundaryAvailability in
			whetherIntervalShouldBeOrderedDescendingly.forEach { intervalShouldBeOrderedDescendingly in
				
				//	MARK: Initialise with Explicit Parameters Values
				
				let lowerUnboundedUpperBoundedRealInterval = Interval(
					fromUnboundedTo: upperBoundedEndpointValue, boundaryAvailability,
					inInverseStridingDirection: intervalShouldBeOrderedDescendingly
				)
				
				if boundaryAvailability == .inclusive {
					XCTAssertEqual(lowerUnboundedUpperBoundedRealInterval.upperBoundaryAccessibility, .closed, "Fails to instantiate an upper-closed lower-unbounded real interval.")
				} else {
					XCTAssertEqual(lowerUnboundedUpperBoundedRealInterval.upperBoundaryAccessibility, .open, "Fails to instantiate an upper-open lower-unbounded real interval.")
				}
				
				XCTAssertEqual(lowerUnboundedUpperBoundedRealInterval.upperEndpoint, upperBoundedEndpoint, "Fails to instantiate a lower-unbounded real interval upper-bounded by \(upperBoundedEndpointValue).")
				
				
				if intervalShouldBeOrderedDescendingly {
					XCTAssertTrue(lowerUnboundedUpperBoundedRealInterval.isInverse, "Fails to instantiate an descendingly ordered lower-unbounded real interval.")
				} else {
					XCTAssertFalse(lowerUnboundedUpperBoundedRealInterval.isInverse, "Fails to instantiate an ascendingly ordered lower-unbounded real interval.")
				}
				
			}
			
			//	MARK: Initialise with Default Parameters Values
			
			let lowerUnboundedUpperBoundedRealInterval = Interval(fromUnboundedTo: upperBoundedEndpointValue, boundaryAvailability)
			
			if boundaryAvailability == .inclusive {
				XCTAssertEqual(lowerUnboundedUpperBoundedRealInterval.upperBoundaryAccessibility, .closed, "Fails to instantiate an upper-closed lower-unbounded real interval.")
			} else {
				XCTAssertEqual(lowerUnboundedUpperBoundedRealInterval.upperBoundaryAccessibility, .open, "Fails to instantiate an upper-open lower-unbounded real interval.")
			}
			
			XCTAssertEqual(lowerUnboundedUpperBoundedRealInterval.upperEndpoint, upperBoundedEndpoint, "Fails to instantiate a lower-unbounded real interval upper-bounded by \(upperBoundedEndpointValue).")
			
			XCTAssertFalse(lowerUnboundedUpperBoundedRealInterval.isInverse, "Fails to instantiate an ascendingly ordered lower-unbounded real interval using the default parameter value.")
			
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
