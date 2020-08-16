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
				
		let lowerEndpoints: [Interval<Int>.Endpoint] = [.unbounded, .bounded(0)]
		let upperEndpoints: [Interval<Int>.Endpoint] = [.unbounded, .bounded(1)]
		let boundaryAccessibilities: [IntervalBoundaryAccessibility] = [.open, .closed]
		let whetherIntervalShouldBeOrderedDescendingly: [Bool] = [true, false]
		
		//	MARK: Initialise with Explicit Parameters Values
		
		lowerEndpoints.forEach { lowerEndpoint in
			upperEndpoints.forEach { upperEndpoint in
				boundaryAccessibilities.forEach { lowerBoundaryAccessibility in
					boundaryAccessibilities.forEach { upperBoundaryAccessibility in
						whetherIntervalShouldBeOrderedDescendingly.forEach { intervalShouldBeOrderedDescendingly in
							
							let realInterval = Interval(
								lowerBoundary: lowerBoundaryAccessibility,
								lowerEndpoint: lowerEndpoint,
								upperEndpoint: upperEndpoint,
								upperBoundary: upperBoundaryAccessibility,
								inInverseStridingDirection: intervalShouldBeOrderedDescendingly
							)
							
							if lowerBoundaryAccessibility == .closed {
								XCTAssertEqual(realInterval.lowerBoundaryAccessibility, .closed, "Fails to instantiate a lower-closed interval.")
							} else {
								XCTAssertEqual(realInterval.lowerBoundaryAccessibility, .open, "Fails to instantiate a lower-open interval.")
							}
							
							if upperBoundaryAccessibility == .closed {
								XCTAssertEqual(realInterval.upperBoundaryAccessibility, .closed, "Fails to instantiate a upper-closed interval.")
							} else {
								XCTAssertEqual(realInterval.upperBoundaryAccessibility, .open, "Fails to instantiate a upper-open interval.")
							}
							
							if lowerEndpoint == .bounded(0) {
								XCTAssertEqual(realInterval.lowerEndpoint, .bounded(0), "Fails to instantiate an interval lower-bounded by 0.")
							} else {
								XCTAssertEqual(realInterval.lowerEndpoint, .unbounded, "Fails to instantiate an lower-unbounded interval.")
							}
							
							if upperEndpoint == .bounded(1) {
								XCTAssertEqual(realInterval.upperEndpoint, .bounded(1), "Fails to instantiate an interval upper-bounded by 1.")
							} else {
								XCTAssertEqual(realInterval.upperEndpoint, .unbounded, "Fails to instantiate an upper-unbounded interval.")
							}
							
							if intervalShouldBeOrderedDescendingly {
								XCTAssertTrue(realInterval.isInverse, "Fails to instantiate an descendingly ordered interval.")
							} else {
								XCTAssertFalse(realInterval.isInverse, "Fails to instantiate an ascendingly ordered interval.")
							}
							
						}
					}
				}
			}
		}
		
		//	MARK: Initialise with Default Parameters Values
		
		lowerEndpoints.forEach { lowerEndpoint in
			upperEndpoints.forEach { upperEndpoint in
				boundaryAccessibilities.forEach { lowerBoundaryAccessibility in
					boundaryAccessibilities.forEach { upperBoundaryAccessibility in
						
						let realInterval = Interval(
							lowerBoundary: lowerBoundaryAccessibility,
							lowerEndpoint: lowerEndpoint,
							upperEndpoint: upperEndpoint,
							upperBoundary: upperBoundaryAccessibility
						)
						
						if lowerBoundaryAccessibility == .closed {
							XCTAssertEqual(realInterval.lowerBoundaryAccessibility, .closed, "Fails to instantiate a lower-closed interval.")
						} else {
							XCTAssertEqual(realInterval.lowerBoundaryAccessibility, .open, "Fails to instantiate a lower-open interval.")
						}
						
						if upperBoundaryAccessibility == .closed {
							XCTAssertEqual(realInterval.upperBoundaryAccessibility, .closed, "Fails to instantiate a upper-closed interval.")
						} else {
							XCTAssertEqual(realInterval.upperBoundaryAccessibility, .open, "Fails to instantiate a upper-open interval.")
						}
						
						if lowerEndpoint == .bounded(0) {
							XCTAssertEqual(realInterval.lowerEndpoint, .bounded(0), "Fails to instantiate an interval lower-bounded by 0.")
						} else {
							XCTAssertEqual(realInterval.lowerEndpoint, .unbounded, "Fails to instantiate an lower-unbounded interval.")
						}
						
						if upperEndpoint == .bounded(1) {
							XCTAssertEqual(realInterval.upperEndpoint, .bounded(1), "Fails to instantiate an interval upper-bounded by 1.")
						} else {
							XCTAssertEqual(realInterval.upperEndpoint, .unbounded, "Fails to instantiate an upper-unbounded interval.")
						}
						
						XCTAssertFalse(realInterval.isInverse, "Fails to instantiate an ascendingly ordered interval using the default parameter value.")
						
					}
				}
			}
		}
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
