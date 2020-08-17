//
//	Interval Initialisation Tests.swift - Test cases and methods regarding instantiating an interval.
//
//	Created by Wowbagger & His Liquid Lunch on 20-08-10.
//

import XCTest
@testable import Interval

///	A group of test cases and methods regarding instantiating `Interval`.
final class IntervalInitialisationTests: XCTestCase {
	
	///	Checks that `Interval`'s primary initialiser works as intended.
	func testPrimaryInitialiser() {
				
		let lowerEndpoints: [Interval<Int>.Endpoint] = [.bounded(0), .unbounded]
		let upperEndpoints: [Interval<Int>.Endpoint] = [.bounded(1), .unbounded]
		let boundaryAccessibilities: [IntervalBoundaryAccessibility] = [.closed, .open]
		let whetherIntervalShouldBeOrderedDescendingly: [Bool] = [true, false]
		
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
							
							if lowerEndpoint == .bounded(0) {
								XCTAssertEqual(realInterval.lowerEndpoint, .bounded(0), "Fails to instantiate a real interval lower-bounded by 0.")
							} else {
								XCTAssertEqual(realInterval.lowerEndpoint, .unbounded, "Fails to instantiate a lower-unbounded real interval.")
							}
							
							if upperEndpoint == .bounded(1) {
								XCTAssertEqual(realInterval.upperEndpoint, .bounded(1), "Fails to instantiate a real interval upper-bounded by 1.")
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
						
						if lowerEndpoint == .bounded(0) {
							XCTAssertEqual(realInterval.lowerEndpoint, .bounded(0), "Fails to instantiate a real interval lower-bounded by 0.")
						} else {
							XCTAssertEqual(realInterval.lowerEndpoint, .unbounded, "Fails to instantiate a lower-unbounded real interval.")
						}
						
						if upperEndpoint == .bounded(1) {
							XCTAssertEqual(realInterval.upperEndpoint, .bounded(1), "Fails to instantiate a real interval upper-bounded by 1.")
						} else {
							XCTAssertEqual(realInterval.upperEndpoint, .unbounded, "Fails to instantiate an upper-unbounded real interval.")
						}
						
						XCTAssertFalse(realInterval.isInverse, "Fails to instantiate an ascendingly ordered real interval using the default parameter value.")
						
					}
				}
			}
		}
		
	}
	
	///	Checks that `Interval`'s secondary initialisers work as intended.
	func testSecondaryInitialisers() {
		
		let lowerEndpoint = 0
		let upperEndpoint = 1
		let boundaryAvailabilities: [IntervalBoundaryAvailability] = [.inclusive, .exclusive]
		let whetherIntervalShouldBeOrderedDescendingly: [Bool] = [true, false]
				
		boundaryAvailabilities.forEach { lowerBoundaryAvailability in
			boundaryAvailabilities.forEach { upperBoundaryAvailability in
				whetherIntervalShouldBeOrderedDescendingly.forEach { intervalShouldBeOrderedDescendingly in
					
					//	MARK: Initialise with Explicit Parameters Values
					
					let realBoundedInterval = Interval(
						from: lowerEndpoint, lowerBoundaryAvailability,
						to: upperEndpoint, upperBoundaryAvailability,
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
					
					XCTAssertEqual(realBoundedInterval.lowerEndpoint, .bounded(0), "Fails to instantiate an interval lower-bounded by 0.")
					XCTAssertEqual(realBoundedInterval.upperEndpoint, .bounded(1), "Fails to instantiate an interval upper-bounded by 1.")
					
					if intervalShouldBeOrderedDescendingly {
						XCTAssertTrue(realBoundedInterval.isInverse, "Fails to instantiate an descendingly ordered bounded interval.")
					} else {
						XCTAssertFalse(realBoundedInterval.isInverse, "Fails to instantiate an ascendingly ordered bounded interval.")
					}
					
				}
				
				//	MARK: Initialise with Default Parameters Values
				
				let realBoundedInterval = Interval(
					from: lowerEndpoint, lowerBoundaryAvailability,
					to: upperEndpoint, upperBoundaryAvailability
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
				
				XCTAssertEqual(realBoundedInterval.lowerEndpoint, .bounded(lowerEndpoint), "Fails to instantiate an interval lower-bounded by 0.")
				XCTAssertEqual(realBoundedInterval.upperEndpoint, .bounded(upperEndpoint), "Fails to instantiate an interval upper-bounded by 1.")
				
				XCTAssertFalse(realBoundedInterval.isInverse, "Fails to instantiate an ascendingly ordered bounded interval using the default parameter value.")
				
			}
		}
				
		boundaryAvailabilities.forEach { boundaryAvailability in
			whetherIntervalShouldBeOrderedDescendingly.forEach { intervalShouldBeOrderedDescendingly in
				
				//	MARK: Initialise with Explicit Parameters Values
				
				let realIntervalWithSymmetricBoundaryConditions = Interval(
					from: lowerEndpoint, to: upperEndpoint, boundaryAvailability,
					inInverseStridingDirection: intervalShouldBeOrderedDescendingly
				)
				
				let upperUnboundedRealInterval = Interval(
					toUnboundedFrom: lowerEndpoint, boundaryAvailability,
					inInverseStridingDirection: intervalShouldBeOrderedDescendingly
				)
				
				let lowerUnboundedRealInterval = Interval(
					fromUnboundedTo: upperEndpoint, boundaryAvailability,
					inInverseStridingDirection: intervalShouldBeOrderedDescendingly
				)
				
				if boundaryAvailability == .inclusive {
					XCTAssertEqual(realIntervalWithSymmetricBoundaryConditions.lowerBoundaryAccessibility, .closed, "Fails to instantiate a lower-closed real interval with symmetric boundary conditions.")
					XCTAssertEqual(realIntervalWithSymmetricBoundaryConditions.upperBoundaryAccessibility, .closed, "Fails to instantiate an upper-closed real interval with symmetric boundary conditions.")
					XCTAssertEqual(upperUnboundedRealInterval.lowerBoundaryAccessibility, .closed, "Fails to instantiate a lower-closed upper-unbounded real interval.")
					XCTAssertEqual(lowerUnboundedRealInterval.upperBoundaryAccessibility, .closed, "Fails to instantiate an upper-closed lower-unbounded real interval.")
				} else {
					XCTAssertEqual(realIntervalWithSymmetricBoundaryConditions.lowerBoundaryAccessibility, .open, "Fails to instantiate a lower-open real interval with symmetric boundary conditions.")
					XCTAssertEqual(realIntervalWithSymmetricBoundaryConditions.upperBoundaryAccessibility, .open, "Fails to instantiate an upper-open real interval with symmetric boundary conditions.")
					XCTAssertEqual(upperUnboundedRealInterval.lowerBoundaryAccessibility, .open, "Fails to instantiate a lower-open upper-unbounded real interval.")
					XCTAssertEqual(lowerUnboundedRealInterval.upperBoundaryAccessibility, .open, "Fails to instantiate an upper-open lower-unbounded real interval.")
				}
				
				XCTAssertEqual(realIntervalWithSymmetricBoundaryConditions.lowerEndpoint, .bounded(lowerEndpoint), "Fails to instantiate a real interval with symmetric boundary conditions lower-bounded by 0.")
				XCTAssertEqual(realIntervalWithSymmetricBoundaryConditions.upperEndpoint, .bounded(upperEndpoint), "Fails to instantiate a real interval with symmetric boundary conditions upper-bounded by 1.")
				XCTAssertEqual(upperUnboundedRealInterval.lowerEndpoint, .bounded(lowerEndpoint), "Fails to instantiate an upper-unbounded real interval lower-bounded by 0.")
				XCTAssertEqual(lowerUnboundedRealInterval.upperEndpoint, .bounded(upperEndpoint), "Fails to instantiate a lower-unbounded real interval upper-bounded by 1.")

				
				if intervalShouldBeOrderedDescendingly {
					XCTAssertTrue(realIntervalWithSymmetricBoundaryConditions.isInverse, "Fails to instantiate an descendingly ordered real interval with symmetric boundary conditions.")
					XCTAssertTrue(upperUnboundedRealInterval.isInverse, "Fails to instantiate an descendingly ordered upper-unbounded real interval.")
					XCTAssertTrue(lowerUnboundedRealInterval.isInverse, "Fails to instantiate an descendingly ordered lower-unbounded real interval.")
				} else {
					XCTAssertFalse(realIntervalWithSymmetricBoundaryConditions.isInverse, "Fails to instantiate an ascendingly ordered real interval with symmetric boundary conditions.")
					XCTAssertFalse(upperUnboundedRealInterval.isInverse, "Fails to instantiate an ascendingly ordered upper-unbounded real interval.")
					XCTAssertFalse(lowerUnboundedRealInterval.isInverse, "Fails to instantiate an ascendingly ordered lower-unbounded real interval.")
				}
				
			}
			
			//	MARK: Initialise with Default Parameters Values
			
			let realIntervalWithSymmetricBoundaryConditions = Interval(from: lowerEndpoint, to: upperEndpoint, boundaryAvailability)
			
			let upperUnboundedRealInterval = Interval(toUnboundedFrom: lowerEndpoint, boundaryAvailability)
			let lowerUnboundedRealInterval = Interval(fromUnboundedTo: upperEndpoint, boundaryAvailability)
			
			if boundaryAvailability == .inclusive {
				XCTAssertEqual(realIntervalWithSymmetricBoundaryConditions.lowerBoundaryAccessibility, .closed, "Fails to instantiate a lower-closed real interval with symmetric boundary conditions.")
				XCTAssertEqual(realIntervalWithSymmetricBoundaryConditions.upperBoundaryAccessibility, .closed, "Fails to instantiate an upper-closed real interval with symmetric boundary conditions.")
				XCTAssertEqual(upperUnboundedRealInterval.lowerBoundaryAccessibility, .closed, "Fails to instantiate a lower-closed upper-unbounded real interval.")
				XCTAssertEqual(lowerUnboundedRealInterval.upperBoundaryAccessibility, .closed, "Fails to instantiate an upper-closed lower-unbounded real interval.")
			} else {
				XCTAssertEqual(realIntervalWithSymmetricBoundaryConditions.lowerBoundaryAccessibility, .open, "Fails to instantiate a lower-open real interval with symmetric boundary conditions.")
				XCTAssertEqual(realIntervalWithSymmetricBoundaryConditions.upperBoundaryAccessibility, .open, "Fails to instantiate an upper-open real interval with symmetric boundary conditions.")
				XCTAssertEqual(upperUnboundedRealInterval.lowerBoundaryAccessibility, .open, "Fails to instantiate a lower-open upper-unbounded real interval.")
				XCTAssertEqual(lowerUnboundedRealInterval.upperBoundaryAccessibility, .open, "Fails to instantiate an upper-open lower-unbounded real interval.")
			}
			
			XCTAssertEqual(realIntervalWithSymmetricBoundaryConditions.lowerEndpoint, .bounded(lowerEndpoint), "Fails to instantiate a real interval with symmetric boundary conditions lower-bounded by 0.")
			XCTAssertEqual(realIntervalWithSymmetricBoundaryConditions.upperEndpoint, .bounded(upperEndpoint), "Fails to instantiate a real interval with symmetric boundary conditions upper-bounded by 1.")
			XCTAssertEqual(upperUnboundedRealInterval.lowerEndpoint, .bounded(lowerEndpoint), "Fails to instantiate an upper-unbounded real interval lower-bounded by 0.")
			XCTAssertEqual(lowerUnboundedRealInterval.upperEndpoint, .bounded(upperEndpoint), "Fails to instantiate a lower-unbounded real interval upper-bounded by 1.")
			
			XCTAssertFalse(realIntervalWithSymmetricBoundaryConditions.isInverse, "Fails to instantiate an ascendingly ordered real interval with symmetric boundary conditions using the default parameter value.")
			XCTAssertFalse(upperUnboundedRealInterval.isInverse, "Fails to instantiate an ascendingly ordered upper-unbounded real interval using the default parameter value.")
			XCTAssertFalse(lowerUnboundedRealInterval.isInverse, "Fails to instantiate an ascendingly ordered lower-unbounded real interval using the default parameter value.")
			
		}
		
	}
	
	///	Checks that `Internal` can correctly initialise from a `ClosedRange` instance.
	func testInitialisingFromClosedRange() {
		XCTAssertEqual(
			Interval(closedRange: 0...1),
			0≤∙≤1,
			"Fails to instantiate a `0≤∙≤1` from `0...1`"
		)
	}
	
	///	Checks that `Internal` can correctly initialise from a `Range` instance.
	func testInitialisingFromRange() {
		XCTAssertEqual(
			Interval(range: 0..<1),
			0≤∙<1,
			"Fails to instantiate a `0≤∙<1` from `0...1`"
		)
	}
	
	///	Checks that `Internal` can correctly initialise from a `PartialRangeFrom` instance.
	func testInitialisingFromLowerBoundedPartialRange() {
		XCTAssertEqual(
			Interval(lowerBoundedPartialRange: 0...),
			0≤∙∙,
			"Fails to instantiate a `0≤∙∙` from `0...`"
		)
	}
	
	///	Checks that `Internal` can correctly initialise from a `PartialRangeThrough` instance.
	func testInitialisingFromUpperBoundedAndClosedPartialRange() {
		XCTAssertEqual(
			Interval(upperBoundedAndClosedPartialRange: ...1),
			∙∙≤1,
			"Fails to instantiate a `∙∙≤1` from `...1`"
		)
	}
	
	///	Checks that `Internal` can correctly initialise from a `PartialRangeTo` instance.
	func testInitialisingFromUpperBoundedAndOpenPartialRange() {
		XCTAssertEqual(
			Interval(upperBoundedAndOpenPartialRange: ..<1),
			∙∙<1,
			"Fails to instantiate a `∙∙<1` from `..<1`"
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
			0≤∙≤1,
			Interval(
				lowerBoundary: .closed,
				lowerEndpoint: .bounded(0),
				upperEndpoint: .bounded(1),
				upperBoundary: .closed,
				inInverseStridingDirection: false
			),
			"`0≤∙≤1` fails to initialise [0, 1]."
		)
		
		XCTAssertEqual(
			0≤∙<1,
			Interval(
				lowerBoundary: .closed,
				lowerEndpoint: .bounded(0),
				upperEndpoint: .bounded(1),
				upperBoundary: .open,
				inInverseStridingDirection: false
			),
			"`0≤∙<1` fails to initialise [0, 1)."
		)
		
		XCTAssertEqual(
			0<∙≤1,
			Interval(
				lowerBoundary: .open,
				lowerEndpoint: .bounded(0),
				upperEndpoint: .bounded(1),
				upperBoundary: .closed,
				inInverseStridingDirection: false
			),
			"`0<∙≤1` fails to initialise (0, 1]."
		)
		
		XCTAssertEqual(
			0<∙<1,
			Interval(
				lowerBoundary: .open,
				lowerEndpoint: .bounded(0),
				upperEndpoint: .bounded(1),
				upperBoundary: .open,
				inInverseStridingDirection: false
			),
			"`0<∙<1` fails to initialise (0, 1)."
		)
		
		XCTAssertEqual(
			∙∙≤1,
			Interval(
				lowerBoundary: .open,
				lowerEndpoint: .unbounded,
				upperEndpoint: .bounded(1),
				upperBoundary: .closed,
				inInverseStridingDirection: false
			),
			"`∙∙≤1` fails to initialise (-∞, 1]."
		)
		
		XCTAssertEqual(
			∙∙<1,
			Interval(
				lowerBoundary: .open,
				lowerEndpoint: .unbounded,
				upperEndpoint: .bounded(1),
				upperBoundary: .open,
				inInverseStridingDirection: false
			),
			"`∙∙<1` fails to initialise (-∞, 1)."
		)
		
		XCTAssertEqual(
			0≤∙∙,
			Interval(
				lowerBoundary: .closed,
				lowerEndpoint: .bounded(0),
				upperEndpoint: .unbounded,
				upperBoundary: .open,
				inInverseStridingDirection: false
			),
			"`0≤∙∙` fails to initialise [0, ∞)."
		)
		
		XCTAssertEqual(
			0<∙∙,
			Interval(
				lowerBoundary: .open,
				lowerEndpoint: .bounded(0),
				upperEndpoint: .unbounded,
				upperBoundary: .open,
				inInverseStridingDirection: false
			),
			"`0<∙∙` fails to initialise (0, ∞)."
		)
		
		//	MARK: Descending interval operators.
		
		XCTAssertEqual(
			1≥∙≥0,
			Interval(
				lowerBoundary: .closed,
				lowerEndpoint: .bounded(0),
				upperEndpoint: .bounded(1),
				upperBoundary: .closed,
				inInverseStridingDirection: true
			),
			"`1≥∙≥0` fails to initialise inverse [0, 1]."
		)
		
		XCTAssertEqual(
			1>∙≥0,
			Interval(
				lowerBoundary: .closed,
				lowerEndpoint: .bounded(0),
				upperEndpoint: .bounded(1),
				upperBoundary: .open,
				inInverseStridingDirection: true
			),
			"`1>∙≥0` fails to initialise inverse [0, 1)."
		)
		
		XCTAssertEqual(
			1≥∙>0,
			Interval(
				lowerBoundary: .open,
				lowerEndpoint: .bounded(0),
				upperEndpoint: .bounded(1),
				upperBoundary: .closed,
				inInverseStridingDirection: true
			),
			"`1≥∙>0` fails to initialise inverse (0, 1]."
		)
		
		XCTAssertEqual(
			1>∙>0,
			Interval(
				lowerBoundary: .open,
				lowerEndpoint: .bounded(0),
				upperEndpoint: .bounded(1),
				upperBoundary: .open,
				inInverseStridingDirection: true
			),
			"`1>∙>0` fails to initialise inverse (0, 1)."
		)
		
		XCTAssertEqual(
			1≥∙∙,
			Interval(
				lowerBoundary: .open,
				lowerEndpoint: .unbounded,
				upperEndpoint: .bounded(1),
				upperBoundary: .closed,
				inInverseStridingDirection: true
			),
			"`1≥∙∙` fails to initialise inverse (-∞, 1]."
		)
		
		XCTAssertEqual(
			1>∙∙,
			Interval(
				lowerBoundary: .open,
				lowerEndpoint: .unbounded,
				upperEndpoint: .bounded(1),
				upperBoundary: .open,
				inInverseStridingDirection: true
			),
			"`1>∙∙` fails to initialise inverse (-∞, 1)."
		)
		
		XCTAssertEqual(
			∙∙≥0,
			Interval(
				lowerBoundary: .closed,
				lowerEndpoint: .bounded(0),
				upperEndpoint: .unbounded,
				upperBoundary: .open,
				inInverseStridingDirection: true
			),
			"`∙∙≥0` fails to initialise inverse [0, ∞)."
		)
		
		XCTAssertEqual(
			∙∙>0,
			Interval(
				lowerBoundary: .open,
				lowerEndpoint: .bounded(0),
				upperEndpoint: .unbounded,
				upperBoundary: .open,
				inInverseStridingDirection: true
			),
			"`∙∙>0` fails to initialise inverse (0, ∞)."
		)
		
	}
	
}
