//
//	Interval Initialisation Tests.swift - Test cases and methods regarding instantiating an interval.
//
//	Created by Wowbagger & His Liquid Lunch on 20-08-10.
//

import XCTest
@testable import Interval

///	A group of test cases and methods regarding instantiating `Interval`.
final class IntervalInitialisationTests: XCTestCase {
	
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
