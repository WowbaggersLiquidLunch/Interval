//
//	Countability Tests.swift - Test cases and methods regarding types' countabilities.
//
//	Created by Wowbagger & His Liquid Lunch on 20-08-10.
//

import XCTest
@testable import Interval

///	A group of test cases regarding types' coutabilities.
final class CountabilityTests: XCTestCase {
	
	///	Checks that `Countable`'s implementation specialised for `BinaryInteger`-conforming types is correct.
	func testBinaryIntegerCountability() {
		
		//	MARK: instance(immediatelyPreceding value: Self) -> Self
		
		XCTAssertEqual(Int8.instance(immediatelyPreceding: 1), 0)
		XCTAssertEqual(UInt8.instance(immediatelyPreceding: 1), 0)
		XCTAssertEqual(Int16.instance(immediatelyPreceding: 1), 0)
		XCTAssertEqual(UInt16.instance(immediatelyPreceding: 1), 0)
		XCTAssertEqual(Int32.instance(immediatelyPreceding: 1), 0)
		XCTAssertEqual(UInt32.instance(immediatelyPreceding: 1), 0)
		XCTAssertEqual(Int64.instance(immediatelyPreceding: 1), 0)
		XCTAssertEqual(UInt64.instance(immediatelyPreceding: 1), 0)
		XCTAssertEqual(Int.instance(immediatelyPreceding: 1), 0)
		XCTAssertEqual(UInt.instance(immediatelyPreceding: 1), 0)
		
		XCTAssertEqual(Int8.instance(immediatelyPreceding: Int8.min + 1), Int8.min)
		XCTAssertEqual(UInt8.instance(immediatelyPreceding: UInt8.min + 1), UInt8.min)
		XCTAssertEqual(Int16.instance(immediatelyPreceding: Int16.min + 1), Int16.min)
		XCTAssertEqual(UInt16.instance(immediatelyPreceding: UInt16.min + 1), UInt16.min)
		XCTAssertEqual(Int32.instance(immediatelyPreceding: Int32.min + 1), Int32.min)
		XCTAssertEqual(UInt32.instance(immediatelyPreceding: UInt32.min + 1), UInt32.min)
		XCTAssertEqual(Int64.instance(immediatelyPreceding: Int64.min + 1), Int64.min)
		XCTAssertEqual(UInt64.instance(immediatelyPreceding: UInt64.min + 1), UInt64.min)
		XCTAssertEqual(Int.instance(immediatelyPreceding: Int.min + 1), Int.min)
		XCTAssertEqual(UInt.instance(immediatelyPreceding: UInt.min + 1), UInt.min)
		
		XCTAssertEqual(Int8.instance(immediatelyPreceding: Int8.max), Int8.max - 1)
		XCTAssertEqual(UInt8.instance(immediatelyPreceding: UInt8.max), UInt8.max - 1)
		XCTAssertEqual(Int16.instance(immediatelyPreceding: Int16.max), Int16.max - 1)
		XCTAssertEqual(UInt16.instance(immediatelyPreceding: UInt16.max), UInt16.max - 1)
		XCTAssertEqual(Int32.instance(immediatelyPreceding: Int32.max), Int32.max - 1)
		XCTAssertEqual(UInt32.instance(immediatelyPreceding: UInt32.max), UInt32.max - 1)
		XCTAssertEqual(Int64.instance(immediatelyPreceding: Int64.max), Int64.max - 1)
		XCTAssertEqual(UInt64.instance(immediatelyPreceding: UInt64.max), UInt64.max - 1)
		XCTAssertEqual(Int.instance(immediatelyPreceding: Int.max), Int.max - 1)
		XCTAssertEqual(UInt.instance(immediatelyPreceding: UInt.max), UInt.max - 1)
		
		XCTAssertNotEqual(Int8.instance(immediatelyPreceding: Int8.max), Int8.min)
		XCTAssertNotEqual(UInt8.instance(immediatelyPreceding: UInt8.max), UInt8.min)
		XCTAssertNotEqual(Int16.instance(immediatelyPreceding: Int16.max), Int16.min)
		XCTAssertNotEqual(UInt16.instance(immediatelyPreceding: UInt16.max), UInt16.min)
		XCTAssertNotEqual(Int32.instance(immediatelyPreceding: Int32.max), Int32.min)
		XCTAssertNotEqual(UInt32.instance(immediatelyPreceding: UInt32.max), UInt32.min)
		XCTAssertNotEqual(Int64.instance(immediatelyPreceding: Int64.max), Int64.min)
		XCTAssertNotEqual(UInt64.instance(immediatelyPreceding: UInt64.max), UInt64.min)
		XCTAssertNotEqual(Int.instance(immediatelyPreceding: Int.max), Int.min)
		XCTAssertNotEqual(UInt.instance(immediatelyPreceding: UInt.max), UInt.min)
		
		//	MARK: instance(immediatelySucceeding value: Self) -> Self
		
		XCTAssertEqual(Int8.instance(immediatelySucceeding: 0), 1)
		XCTAssertEqual(UInt8.instance(immediatelySucceeding: 0), 1)
		XCTAssertEqual(Int16.instance(immediatelySucceeding: 0), 1)
		XCTAssertEqual(UInt16.instance(immediatelySucceeding: 0), 1)
		XCTAssertEqual(Int32.instance(immediatelySucceeding: 0), 1)
		XCTAssertEqual(UInt32.instance(immediatelySucceeding: 0), 1)
		XCTAssertEqual(Int64.instance(immediatelySucceeding: 0), 1)
		XCTAssertEqual(UInt64.instance(immediatelySucceeding: 0), 1)
		XCTAssertEqual(Int.instance(immediatelySucceeding: 0), 1)
		XCTAssertEqual(UInt.instance(immediatelySucceeding: 0), 1)
		
		XCTAssertEqual(Int8.instance(immediatelySucceeding: Int8.min), Int8.min + 1)
		XCTAssertEqual(UInt8.instance(immediatelySucceeding: UInt8.min), UInt8.min + 1)
		XCTAssertEqual(Int16.instance(immediatelySucceeding: Int16.min), Int16.min + 1)
		XCTAssertEqual(UInt16.instance(immediatelySucceeding: UInt16.min), UInt16.min + 1)
		XCTAssertEqual(Int32.instance(immediatelySucceeding: Int32.min), Int32.min + 1)
		XCTAssertEqual(UInt32.instance(immediatelySucceeding: UInt32.min), UInt32.min + 1)
		XCTAssertEqual(Int64.instance(immediatelySucceeding: Int64.min), Int64.min + 1)
		XCTAssertEqual(UInt64.instance(immediatelySucceeding: UInt64.min), UInt64.min + 1)
		XCTAssertEqual(Int.instance(immediatelySucceeding: Int.min), Int.min + 1)
		XCTAssertEqual(UInt.instance(immediatelySucceeding: UInt.min), UInt.min + 1)
		
		XCTAssertEqual(Int8.instance(immediatelySucceeding: Int8.max - 1), Int8.max)
		XCTAssertEqual(UInt8.instance(immediatelySucceeding: UInt8.max - 1), UInt8.max)
		XCTAssertEqual(Int16.instance(immediatelySucceeding: Int16.max - 1), Int16.max)
		XCTAssertEqual(UInt16.instance(immediatelySucceeding: UInt16.max - 1), UInt16.max)
		XCTAssertEqual(Int32.instance(immediatelySucceeding: Int32.max - 1), Int32.max)
		XCTAssertEqual(UInt32.instance(immediatelySucceeding: UInt32.max - 1), UInt32.max)
		XCTAssertEqual(Int64.instance(immediatelySucceeding: Int64.max - 1), Int64.max)
		XCTAssertEqual(UInt64.instance(immediatelySucceeding: UInt64.max - 1), UInt64.max)
		XCTAssertEqual(Int.instance(immediatelySucceeding: Int.max - 1), Int.max)
		XCTAssertEqual(UInt.instance(immediatelySucceeding: UInt.max - 1), UInt.max)
		
		XCTAssertNotEqual(Int8.instance(immediatelySucceeding: Int8.min), Int8.max)
		XCTAssertNotEqual(UInt8.instance(immediatelySucceeding: UInt8.min), UInt8.max)
		XCTAssertNotEqual(Int16.instance(immediatelySucceeding: Int16.min), Int16.max)
		XCTAssertNotEqual(UInt16.instance(immediatelySucceeding: UInt16.min), UInt16.max)
		XCTAssertNotEqual(Int32.instance(immediatelySucceeding: Int32.min), Int32.max)
		XCTAssertNotEqual(UInt32.instance(immediatelySucceeding: UInt32.min), UInt32.max)
		XCTAssertNotEqual(Int64.instance(immediatelySucceeding: Int64.min), Int64.max)
		XCTAssertNotEqual(UInt64.instance(immediatelySucceeding: UInt64.min), UInt64.max)
		XCTAssertNotEqual(Int.instance(immediatelySucceeding: Int.min), Int.max)
		XCTAssertNotEqual(UInt.instance(immediatelySucceeding: UInt.min), UInt.max)
		
		//	MARK: immediatePredecessor
		
		XCTAssertEqual(1.immediatePredecessor, 0)
		
		XCTAssertEqual((Int8.min + 1).immediatePredecessor, Int8.min)
		XCTAssertEqual((UInt8.min + 1).immediatePredecessor, UInt8.min)
		XCTAssertEqual((Int16.min + 1).immediatePredecessor, Int16.min)
		XCTAssertEqual((UInt16.min + 1).immediatePredecessor, UInt16.min)
		XCTAssertEqual((Int32.min + 1).immediatePredecessor, Int32.min)
		XCTAssertEqual((UInt32.min + 1).immediatePredecessor, UInt32.min)
		XCTAssertEqual((Int64.min + 1).immediatePredecessor, Int64.min)
		XCTAssertEqual((UInt64.min + 1).immediatePredecessor, UInt64.min)
		XCTAssertEqual((Int.min + 1).immediatePredecessor, Int.min)
		XCTAssertEqual((UInt.min + 1).immediatePredecessor, UInt.min)
		
		XCTAssertEqual((Int8.max).immediatePredecessor, Int8.max - 1)
		XCTAssertEqual((UInt8.max).immediatePredecessor, UInt8.max - 1)
		XCTAssertEqual((Int16.max).immediatePredecessor, Int16.max - 1)
		XCTAssertEqual((UInt16.max).immediatePredecessor, UInt16.max - 1)
		XCTAssertEqual((Int32.max).immediatePredecessor, Int32.max - 1)
		XCTAssertEqual((UInt32.max).immediatePredecessor, UInt32.max - 1)
		XCTAssertEqual((Int64.max).immediatePredecessor, Int64.max - 1)
		XCTAssertEqual((UInt64.max).immediatePredecessor, UInt64.max - 1)
		XCTAssertEqual((Int.max).immediatePredecessor, Int.max - 1)
		XCTAssertEqual((UInt.max).immediatePredecessor, UInt.max - 1)
		
		XCTAssertNotEqual((Int8.max).immediatePredecessor, Int8.min)
		XCTAssertNotEqual((UInt8.max).immediatePredecessor, UInt8.min)
		XCTAssertNotEqual((Int16.max).immediatePredecessor, Int16.min)
		XCTAssertNotEqual((UInt16.max).immediatePredecessor, UInt16.min)
		XCTAssertNotEqual((Int32.max).immediatePredecessor, Int32.min)
		XCTAssertNotEqual((UInt32.max).immediatePredecessor, UInt32.min)
		XCTAssertNotEqual((Int64.max).immediatePredecessor, Int64.min)
		XCTAssertNotEqual((UInt64.max).immediatePredecessor, UInt64.min)
		XCTAssertNotEqual((Int.max).immediatePredecessor, Int.min)
		XCTAssertNotEqual((UInt.max).immediatePredecessor, UInt.min)
		
		//	MARK: immediateSuccessor
		
		XCTAssertEqual(0.immediateSuccessor, 1)
		
		XCTAssertEqual((Int8.min).immediateSuccessor, Int8.min + 1)
		XCTAssertEqual((UInt8.min).immediateSuccessor, UInt8.min + 1)
		XCTAssertEqual((Int16.min).immediateSuccessor, Int16.min + 1)
		XCTAssertEqual((UInt16.min).immediateSuccessor, UInt16.min + 1)
		XCTAssertEqual((Int32.min).immediateSuccessor, Int32.min + 1)
		XCTAssertEqual((UInt32.min).immediateSuccessor, UInt32.min + 1)
		XCTAssertEqual((Int64.min).immediateSuccessor, Int64.min + 1)
		XCTAssertEqual((UInt64.min).immediateSuccessor, UInt64.min + 1)
		XCTAssertEqual((Int.min).immediateSuccessor, Int.min + 1)
		XCTAssertEqual((UInt.min).immediateSuccessor, UInt.min + 1)
		
		XCTAssertEqual((Int8.max - 1).immediateSuccessor, Int8.max)
		XCTAssertEqual((UInt8.max - 1).immediateSuccessor, UInt8.max)
		XCTAssertEqual((Int16.max - 1).immediateSuccessor, Int16.max)
		XCTAssertEqual((UInt16.max - 1).immediateSuccessor, UInt16.max)
		XCTAssertEqual((Int32.max - 1).immediateSuccessor, Int32.max)
		XCTAssertEqual((UInt32.max - 1).immediateSuccessor, UInt32.max)
		XCTAssertEqual((Int64.max - 1).immediateSuccessor, Int64.max)
		XCTAssertEqual((UInt64.max - 1).immediateSuccessor, UInt64.max)
		XCTAssertEqual((Int.max - 1).immediateSuccessor, Int.max)
		XCTAssertEqual((UInt.max - 1).immediateSuccessor, UInt.max)
		
		XCTAssertNotEqual((Int8.min).immediateSuccessor, Int8.max)
		XCTAssertNotEqual((UInt8.min).immediateSuccessor, UInt8.max)
		XCTAssertNotEqual((Int16.min).immediateSuccessor, Int16.max)
		XCTAssertNotEqual((UInt16.min).immediateSuccessor, UInt16.max)
		XCTAssertNotEqual((Int32.min).immediateSuccessor, Int32.max)
		XCTAssertNotEqual((UInt32.min).immediateSuccessor, UInt32.max)
		XCTAssertNotEqual((Int64.min).immediateSuccessor, Int64.max)
		XCTAssertNotEqual((UInt64.min).immediateSuccessor, UInt64.max)
		XCTAssertNotEqual((Int.min).immediateSuccessor, Int.max)
		XCTAssertNotEqual((UInt.min).immediateSuccessor, UInt.max)
		
		//	MARK: immediatelyPrecedes(_ other: Self) -> Bool
		
		XCTAssertTrue(0.immediatelyPrecedes(1))
		XCTAssertFalse(1.immediatelyPrecedes(0))
		
		XCTAssertTrue(Int8.min.immediatelyPrecedes(Int8.min + 1))
		XCTAssertTrue(UInt8.min.immediatelyPrecedes(UInt8.min + 1))
		XCTAssertTrue(Int16.min.immediatelyPrecedes(Int16.min + 1))
		XCTAssertTrue(UInt16.min.immediatelyPrecedes(UInt16.min + 1))
		XCTAssertTrue(Int32.min.immediatelyPrecedes(Int32.min + 1))
		XCTAssertTrue(UInt32.min.immediatelyPrecedes(UInt32.min + 1))
		XCTAssertTrue(Int64.min.immediatelyPrecedes(Int64.min + 1))
		XCTAssertTrue(UInt64.min.immediatelyPrecedes(UInt64.min + 1))
		XCTAssertTrue(Int.min.immediatelyPrecedes(Int.min + 1))
		XCTAssertTrue(UInt.min.immediatelyPrecedes(UInt.min + 1))
		
		XCTAssertFalse((Int8.min + 1).immediatelyPrecedes(Int8.min))
		XCTAssertFalse((UInt8.min + 1).immediatelyPrecedes(UInt8.min))
		XCTAssertFalse((Int16.min + 1).immediatelyPrecedes(Int16.min))
		XCTAssertFalse((UInt16.min + 1).immediatelyPrecedes(UInt16.min))
		XCTAssertFalse((Int32.min + 1).immediatelyPrecedes(Int32.min))
		XCTAssertFalse((UInt32.min + 1).immediatelyPrecedes(UInt32.min))
		XCTAssertFalse((Int64.min + 1).immediatelyPrecedes(Int64.min))
		XCTAssertFalse((UInt64.min + 1).immediatelyPrecedes(UInt64.min))
		XCTAssertFalse((Int.min + 1).immediatelyPrecedes(Int.min))
		XCTAssertFalse((UInt.min + 1).immediatelyPrecedes(UInt.min))
		
		XCTAssertTrue((Int8.max - 1).immediatelyPrecedes(Int8.max))
		XCTAssertTrue((UInt8.max - 1).immediatelyPrecedes(UInt8.max))
		XCTAssertTrue((Int16.max - 1).immediatelyPrecedes(Int16.max))
		XCTAssertTrue((UInt16.max - 1).immediatelyPrecedes(UInt16.max))
		XCTAssertTrue((Int32.max - 1).immediatelyPrecedes(Int32.max))
		XCTAssertTrue((UInt32.max - 1).immediatelyPrecedes(UInt32.max))
		XCTAssertTrue((Int64.max - 1).immediatelyPrecedes(Int64.max))
		XCTAssertTrue((UInt64.max - 1).immediatelyPrecedes(UInt64.max))
		XCTAssertTrue((Int.max - 1).immediatelyPrecedes(Int.max))
		XCTAssertTrue((UInt.max - 1).immediatelyPrecedes(UInt.max))
		
		XCTAssertFalse(Int8.max.immediatelyPrecedes(Int8.max - 1))
		XCTAssertFalse(UInt8.max.immediatelyPrecedes(UInt8.max - 1))
		XCTAssertFalse(Int16.max.immediatelyPrecedes(Int16.max - 1))
		XCTAssertFalse(UInt16.max.immediatelyPrecedes(UInt16.max - 1))
		XCTAssertFalse(Int32.max.immediatelyPrecedes(Int32.max - 1))
		XCTAssertFalse(UInt32.max.immediatelyPrecedes(UInt32.max - 1))
		XCTAssertFalse(Int64.max.immediatelyPrecedes(Int64.max - 1))
		XCTAssertFalse(UInt64.max.immediatelyPrecedes(UInt64.max - 1))
		XCTAssertFalse(Int.max.immediatelyPrecedes(Int.max - 1))
		XCTAssertFalse(UInt.max.immediatelyPrecedes(UInt.max - 1))
		
		XCTAssertFalse(Int8.min.immediatelyPrecedes(Int8.max))
		XCTAssertFalse(UInt8.min.immediatelyPrecedes(UInt8.max))
		XCTAssertFalse(Int16.min.immediatelyPrecedes(Int16.max))
		XCTAssertFalse(UInt16.min.immediatelyPrecedes(UInt16.max))
		XCTAssertFalse(Int32.min.immediatelyPrecedes(Int32.max))
		XCTAssertFalse(UInt32.min.immediatelyPrecedes(UInt32.max))
		XCTAssertFalse(Int64.min.immediatelyPrecedes(Int64.max))
		XCTAssertFalse(UInt64.min.immediatelyPrecedes(UInt64.max))
		XCTAssertFalse(Int.min.immediatelyPrecedes(Int.max))
		XCTAssertFalse(UInt.min.immediatelyPrecedes(UInt.max))
		
		XCTAssertFalse(Int8.max.immediatelyPrecedes(Int8.min))
		XCTAssertFalse(UInt8.max.immediatelyPrecedes(UInt8.min))
		XCTAssertFalse(Int16.max.immediatelyPrecedes(Int16.min))
		XCTAssertFalse(UInt16.max.immediatelyPrecedes(UInt16.min))
		XCTAssertFalse(Int32.max.immediatelyPrecedes(Int32.min))
		XCTAssertFalse(UInt32.max.immediatelyPrecedes(UInt32.min))
		XCTAssertFalse(Int64.max.immediatelyPrecedes(Int64.min))
		XCTAssertFalse(UInt64.max.immediatelyPrecedes(UInt64.min))
		XCTAssertFalse(Int.max.immediatelyPrecedes(Int.min))
		XCTAssertFalse(UInt.max.immediatelyPrecedes(UInt.min))
		
		//	MARK: immediatelySucceeds(_ other: Self) -> Bool
		
		XCTAssertTrue(1.immediatelySucceeds(0))
		XCTAssertFalse(0.immediatelySucceeds(1))
		
		XCTAssertTrue((Int8.min + 1).immediatelySucceeds(Int8.min))
		XCTAssertTrue((UInt8.min + 1).immediatelySucceeds(UInt8.min))
		XCTAssertTrue((Int16.min + 1).immediatelySucceeds(Int16.min))
		XCTAssertTrue((UInt16.min + 1).immediatelySucceeds(UInt16.min))
		XCTAssertTrue((Int32.min + 1).immediatelySucceeds(Int32.min))
		XCTAssertTrue((UInt32.min + 1).immediatelySucceeds(UInt32.min))
		XCTAssertTrue((Int64.min + 1).immediatelySucceeds(Int64.min))
		XCTAssertTrue((UInt64.min + 1).immediatelySucceeds(UInt64.min))
		XCTAssertTrue((Int.min + 1).immediatelySucceeds(Int.min))
		XCTAssertTrue((UInt.min + 1).immediatelySucceeds(UInt.min))
		
		XCTAssertFalse(Int8.min.immediatelySucceeds(Int8.min + 1))
		XCTAssertFalse(UInt8.min.immediatelySucceeds(UInt8.min + 1))
		XCTAssertFalse(Int16.min.immediatelySucceeds(Int16.min + 1))
		XCTAssertFalse(UInt16.min.immediatelySucceeds(UInt16.min + 1))
		XCTAssertFalse(Int32.min.immediatelySucceeds(Int32.min + 1))
		XCTAssertFalse(UInt32.min.immediatelySucceeds(UInt32.min + 1))
		XCTAssertFalse(Int64.min.immediatelySucceeds(Int64.min + 1))
		XCTAssertFalse(UInt64.min.immediatelySucceeds(UInt64.min + 1))
		XCTAssertFalse(Int.min.immediatelySucceeds(Int.min + 1))
		XCTAssertFalse(UInt.min.immediatelySucceeds(UInt.min + 1))
		
		XCTAssertTrue(Int8.max.immediatelySucceeds(Int8.max - 1))
		XCTAssertTrue(UInt8.max.immediatelySucceeds(UInt8.max - 1))
		XCTAssertTrue(Int16.max.immediatelySucceeds(Int16.max - 1))
		XCTAssertTrue(UInt16.max.immediatelySucceeds(UInt16.max - 1))
		XCTAssertTrue(Int32.max.immediatelySucceeds(Int32.max - 1))
		XCTAssertTrue(UInt32.max.immediatelySucceeds(UInt32.max - 1))
		XCTAssertTrue(Int64.max.immediatelySucceeds(Int64.max - 1))
		XCTAssertTrue(UInt64.max.immediatelySucceeds(UInt64.max - 1))
		XCTAssertTrue(Int.max.immediatelySucceeds(Int.max - 1))
		XCTAssertTrue(UInt.max.immediatelySucceeds(UInt.max - 1))
		
		XCTAssertFalse((Int8.max - 1).immediatelySucceeds(Int8.max))
		XCTAssertFalse((UInt8.max - 1).immediatelySucceeds(UInt8.max))
		XCTAssertFalse((Int16.max - 1).immediatelySucceeds(Int16.max))
		XCTAssertFalse((UInt16.max - 1).immediatelySucceeds(UInt16.max))
		XCTAssertFalse((Int32.max - 1).immediatelySucceeds(Int32.max))
		XCTAssertFalse((UInt32.max - 1).immediatelySucceeds(UInt32.max))
		XCTAssertFalse((Int64.max - 1).immediatelySucceeds(Int64.max))
		XCTAssertFalse((UInt64.max - 1).immediatelySucceeds(UInt64.max))
		XCTAssertFalse((Int.max - 1).immediatelySucceeds(Int.max))
		XCTAssertFalse((UInt.max - 1).immediatelySucceeds(UInt.max))
		
		XCTAssertFalse(Int8.max.immediatelySucceeds(Int8.min))
		XCTAssertFalse(UInt8.max.immediatelySucceeds(UInt8.min))
		XCTAssertFalse(Int16.max.immediatelySucceeds(Int16.min))
		XCTAssertFalse(UInt16.max.immediatelySucceeds(UInt16.min))
		XCTAssertFalse(Int32.max.immediatelySucceeds(Int32.min))
		XCTAssertFalse(UInt32.max.immediatelySucceeds(UInt32.min))
		XCTAssertFalse(Int64.max.immediatelySucceeds(Int64.min))
		XCTAssertFalse(UInt64.max.immediatelySucceeds(UInt64.min))
		XCTAssertFalse(Int.max.immediatelySucceeds(Int.min))
		XCTAssertFalse(UInt.max.immediatelySucceeds(UInt.min))
		
		XCTAssertFalse(Int8.min.immediatelySucceeds(Int8.max))
		XCTAssertFalse(UInt8.min.immediatelySucceeds(UInt8.max))
		XCTAssertFalse(Int16.min.immediatelySucceeds(Int16.max))
		XCTAssertFalse(UInt16.min.immediatelySucceeds(UInt16.max))
		XCTAssertFalse(Int32.min.immediatelySucceeds(Int32.max))
		XCTAssertFalse(UInt32.min.immediatelySucceeds(UInt32.max))
		XCTAssertFalse(Int64.min.immediatelySucceeds(Int64.max))
		XCTAssertFalse(UInt64.min.immediatelySucceeds(UInt64.max))
		XCTAssertFalse(Int.min.immediatelySucceeds(Int.max))
		XCTAssertFalse(UInt.min.immediatelySucceeds(UInt.max))
		
		//	MARK: borders(on other: Self) -> Bool
		
		XCTAssertTrue(0.borders(on: 1))
		XCTAssertTrue(1.borders(on: 0))
		XCTAssertFalse((-1).borders(on: 1))
		
		XCTAssertTrue(Int8.min.borders(on: Int8.min + 1))
		XCTAssertTrue(UInt8.min.borders(on: UInt8.min + 1))
		XCTAssertTrue(Int16.min.borders(on: Int16.min + 1))
		XCTAssertTrue(UInt16.min.borders(on: UInt16.min + 1))
		XCTAssertTrue(Int32.min.borders(on: Int32.min + 1))
		XCTAssertTrue(UInt32.min.borders(on: UInt32.min + 1))
		XCTAssertTrue(Int64.min.borders(on: Int64.min + 1))
		XCTAssertTrue(UInt64.min.borders(on: UInt64.min + 1))
		XCTAssertTrue(Int.min.borders(on: Int.min + 1))
		XCTAssertTrue(UInt.min.borders(on: UInt.min + 1))
		
		XCTAssertTrue(Int8.max.borders(on: Int8.max - 1))
		XCTAssertTrue(UInt8.max.borders(on: UInt8.max - 1))
		XCTAssertTrue(Int16.max.borders(on: Int16.max - 1))
		XCTAssertTrue(UInt16.max.borders(on: UInt16.max - 1))
		XCTAssertTrue(Int32.max.borders(on: Int32.max - 1))
		XCTAssertTrue(UInt32.max.borders(on: UInt32.max - 1))
		XCTAssertTrue(Int64.max.borders(on: Int64.max - 1))
		XCTAssertTrue(UInt64.max.borders(on: UInt64.max - 1))
		XCTAssertTrue(Int.max.borders(on: Int.max - 1))
		XCTAssertTrue(UInt.max.borders(on: UInt.max - 1))
		
		XCTAssertFalse(Int8.min.borders(on: Int8.max))
		XCTAssertFalse(UInt8.min.borders(on: UInt8.max))
		XCTAssertFalse(Int16.min.borders(on: Int16.max))
		XCTAssertFalse(UInt16.min.borders(on: UInt16.max))
		XCTAssertFalse(Int32.min.borders(on: Int32.max))
		XCTAssertFalse(UInt32.min.borders(on: UInt32.max))
		XCTAssertFalse(Int64.min.borders(on: Int64.max))
		XCTAssertFalse(UInt64.min.borders(on: UInt64.max))
		XCTAssertFalse(Int.min.borders(on: Int.max))
		XCTAssertFalse(UInt.min.borders(on: UInt.max))
		
		//	MARK: sharesCommonNeighbor(with other: Self) -> Bool
		
		XCTAssertTrue(0.sharesCommonNeighbor(with: 2))
		XCTAssertTrue(0.sharesCommonNeighbor(with: 0))
		XCTAssertFalse(0.sharesCommonNeighbor(with: 1))
		XCTAssertFalse(0.sharesCommonNeighbor(with: 3))
		
		XCTAssertTrue(Int8.min.sharesCommonNeighbor(with: Int8.min + 2))
		XCTAssertTrue(UInt8.min.sharesCommonNeighbor(with: UInt8.min + 2))
		XCTAssertTrue(Int16.min.sharesCommonNeighbor(with: Int16.min + 2))
		XCTAssertTrue(UInt16.min.sharesCommonNeighbor(with: UInt16.min + 2))
		XCTAssertTrue(Int32.min.sharesCommonNeighbor(with: Int32.min + 2))
		XCTAssertTrue(UInt32.min.sharesCommonNeighbor(with: UInt32.min + 2))
		XCTAssertTrue(Int64.min.sharesCommonNeighbor(with: Int64.min + 2))
		XCTAssertTrue(UInt64.min.sharesCommonNeighbor(with: UInt64.min + 2))
		XCTAssertTrue(Int.min.sharesCommonNeighbor(with: Int.min + 2))
		XCTAssertTrue(UInt.min.sharesCommonNeighbor(with: UInt.min + 2))
		
		XCTAssertTrue(Int8.min.sharesCommonNeighbor(with: Int8.min))
		XCTAssertTrue(UInt8.min.sharesCommonNeighbor(with: UInt8.min))
		XCTAssertTrue(Int16.min.sharesCommonNeighbor(with: Int16.min))
		XCTAssertTrue(UInt16.min.sharesCommonNeighbor(with: UInt16.min))
		XCTAssertTrue(Int32.min.sharesCommonNeighbor(with: Int32.min))
		XCTAssertTrue(UInt32.min.sharesCommonNeighbor(with: UInt32.min))
		XCTAssertTrue(Int64.min.sharesCommonNeighbor(with: Int64.min))
		XCTAssertTrue(UInt64.min.sharesCommonNeighbor(with: UInt64.min))
		XCTAssertTrue(Int.min.sharesCommonNeighbor(with: Int.min))
		XCTAssertTrue(UInt.min.sharesCommonNeighbor(with: UInt.min))
		
		XCTAssertFalse(Int8.min.sharesCommonNeighbor(with: Int8.min + 1))
		XCTAssertFalse(UInt8.min.sharesCommonNeighbor(with: UInt8.min + 1))
		XCTAssertFalse(Int16.min.sharesCommonNeighbor(with: Int16.min + 1))
		XCTAssertFalse(UInt16.min.sharesCommonNeighbor(with: UInt16.min + 1))
		XCTAssertFalse(Int32.min.sharesCommonNeighbor(with: Int32.min + 1))
		XCTAssertFalse(UInt32.min.sharesCommonNeighbor(with: UInt32.min + 1))
		XCTAssertFalse(Int64.min.sharesCommonNeighbor(with: Int64.min + 1))
		XCTAssertFalse(UInt64.min.sharesCommonNeighbor(with: UInt64.min + 1))
		XCTAssertFalse(Int.min.sharesCommonNeighbor(with: Int.min + 1))
		XCTAssertFalse(UInt.min.sharesCommonNeighbor(with: UInt.min + 1))
		
		XCTAssertFalse(Int8.min.sharesCommonNeighbor(with: Int8.min + 3))
		XCTAssertFalse(UInt8.min.sharesCommonNeighbor(with: UInt8.min + 3))
		XCTAssertFalse(Int16.min.sharesCommonNeighbor(with: Int16.min + 3))
		XCTAssertFalse(UInt16.min.sharesCommonNeighbor(with: UInt16.min + 3))
		XCTAssertFalse(Int32.min.sharesCommonNeighbor(with: Int32.min + 3))
		XCTAssertFalse(UInt32.min.sharesCommonNeighbor(with: UInt32.min + 3))
		XCTAssertFalse(Int64.min.sharesCommonNeighbor(with: Int64.min + 3))
		XCTAssertFalse(UInt64.min.sharesCommonNeighbor(with: UInt64.min + 3))
		XCTAssertFalse(Int.min.sharesCommonNeighbor(with: Int.min + 3))
		XCTAssertFalse(UInt.min.sharesCommonNeighbor(with: UInt.min + 3))
		
		XCTAssertTrue(Int8.max.sharesCommonNeighbor(with: Int8.max - 2))
		XCTAssertTrue(UInt8.max.sharesCommonNeighbor(with: UInt8.max - 2))
		XCTAssertTrue(Int16.max.sharesCommonNeighbor(with: Int16.max - 2))
		XCTAssertTrue(UInt16.max.sharesCommonNeighbor(with: UInt16.max - 2))
		XCTAssertTrue(Int32.max.sharesCommonNeighbor(with: Int32.max - 2))
		XCTAssertTrue(UInt32.max.sharesCommonNeighbor(with: UInt32.max - 2))
		XCTAssertTrue(Int64.max.sharesCommonNeighbor(with: Int64.max - 2))
		XCTAssertTrue(UInt64.max.sharesCommonNeighbor(with: UInt64.max - 2))
		XCTAssertTrue(Int.max.sharesCommonNeighbor(with: Int.max - 2))
		XCTAssertTrue(UInt.max.sharesCommonNeighbor(with: UInt.max - 2))
		
		XCTAssertTrue(Int8.max.sharesCommonNeighbor(with: Int8.max))
		XCTAssertTrue(UInt8.max.sharesCommonNeighbor(with: UInt8.max))
		XCTAssertTrue(Int16.max.sharesCommonNeighbor(with: Int16.max))
		XCTAssertTrue(UInt16.max.sharesCommonNeighbor(with: UInt16.max))
		XCTAssertTrue(Int32.max.sharesCommonNeighbor(with: Int32.max))
		XCTAssertTrue(UInt32.max.sharesCommonNeighbor(with: UInt32.max))
		XCTAssertTrue(Int64.max.sharesCommonNeighbor(with: Int64.max))
		XCTAssertTrue(UInt64.max.sharesCommonNeighbor(with: UInt64.max))
		XCTAssertTrue(Int.max.sharesCommonNeighbor(with: Int.max))
		XCTAssertTrue(UInt.max.sharesCommonNeighbor(with: UInt.max))
		
		XCTAssertFalse(Int8.max.sharesCommonNeighbor(with: Int8.max - 1))
		XCTAssertFalse(UInt8.max.sharesCommonNeighbor(with: UInt8.max - 1))
		XCTAssertFalse(Int16.max.sharesCommonNeighbor(with: Int16.max - 1))
		XCTAssertFalse(UInt16.max.sharesCommonNeighbor(with: UInt16.max - 1))
		XCTAssertFalse(Int32.max.sharesCommonNeighbor(with: Int32.max - 1))
		XCTAssertFalse(UInt32.max.sharesCommonNeighbor(with: UInt32.max - 1))
		XCTAssertFalse(Int64.max.sharesCommonNeighbor(with: Int64.max - 1))
		XCTAssertFalse(UInt64.max.sharesCommonNeighbor(with: UInt64.max - 1))
		XCTAssertFalse(Int.max.sharesCommonNeighbor(with: Int.max - 1))
		XCTAssertFalse(UInt.max.sharesCommonNeighbor(with: UInt.max - 1))
		
		XCTAssertFalse(Int8.max.sharesCommonNeighbor(with: Int8.max - 3))
		XCTAssertFalse(UInt8.max.sharesCommonNeighbor(with: UInt8.max - 3))
		XCTAssertFalse(Int16.max.sharesCommonNeighbor(with: Int16.max - 3))
		XCTAssertFalse(UInt16.max.sharesCommonNeighbor(with: UInt16.max - 3))
		XCTAssertFalse(Int32.max.sharesCommonNeighbor(with: Int32.max - 3))
		XCTAssertFalse(UInt32.max.sharesCommonNeighbor(with: UInt32.max - 3))
		XCTAssertFalse(Int64.max.sharesCommonNeighbor(with: Int64.max - 3))
		XCTAssertFalse(UInt64.max.sharesCommonNeighbor(with: UInt64.max - 3))
		XCTAssertFalse(Int.max.sharesCommonNeighbor(with: Int.max - 3))
		XCTAssertFalse(UInt.max.sharesCommonNeighbor(with: UInt.max - 3))
		
		XCTAssertFalse(Int8.min.sharesCommonNeighbor(with: Int8.max))
		XCTAssertFalse(UInt8.min.sharesCommonNeighbor(with: UInt8.max))
		XCTAssertFalse(Int16.min.sharesCommonNeighbor(with: Int16.max))
		XCTAssertFalse(UInt16.min.sharesCommonNeighbor(with: UInt16.max))
		XCTAssertFalse(Int32.min.sharesCommonNeighbor(with: Int32.max))
		XCTAssertFalse(UInt32.min.sharesCommonNeighbor(with: UInt32.max))
		XCTAssertFalse(Int64.min.sharesCommonNeighbor(with: Int64.max))
		XCTAssertFalse(UInt64.min.sharesCommonNeighbor(with: UInt64.max))
		XCTAssertFalse(Int.min.sharesCommonNeighbor(with: Int.max))
		XCTAssertFalse(UInt.min.sharesCommonNeighbor(with: UInt.max))
		
		//	separates(from other: Self, byDegrees degrees: Stride) -> Bool
		
		XCTAssertTrue(0.separates(from: 0, byDegrees: 0))
		XCTAssertTrue(0.separates(from: 1, byDegrees: 1))
		XCTAssertFalse(0.separates(from: 0, byDegrees: 1))
		XCTAssertFalse(0.separates(from: 1, byDegrees: 0))
		
		XCTAssertTrue(Int8.min.separates(from: Int8.min, byDegrees: 0))
		XCTAssertTrue(UInt8.min.separates(from: UInt8.min, byDegrees: 0))
		XCTAssertTrue(Int16.min.separates(from: Int16.min, byDegrees: 0))
		XCTAssertTrue(UInt16.min.separates(from: UInt16.min, byDegrees: 0))
		XCTAssertTrue(Int32.min.separates(from: Int32.min, byDegrees: 0))
		XCTAssertTrue(UInt32.min.separates(from: UInt32.min, byDegrees: 0))
		XCTAssertTrue(Int64.min.separates(from: Int64.min, byDegrees: 0))
		XCTAssertTrue(UInt64.min.separates(from: UInt64.min, byDegrees: 0))
		XCTAssertTrue(Int.min.separates(from: Int.min, byDegrees: 0))
		XCTAssertTrue(UInt.min.separates(from: UInt.min, byDegrees: 0))
		
		XCTAssertTrue(Int8.min.separates(from: Int8.min + 1, byDegrees: 1))
		XCTAssertTrue(UInt8.min.separates(from: UInt8.min + 1, byDegrees: 1))
		XCTAssertTrue(Int16.min.separates(from: Int16.min + 1, byDegrees: 1))
		XCTAssertTrue(UInt16.min.separates(from: UInt16.min + 1, byDegrees: 1))
		XCTAssertTrue(Int32.min.separates(from: Int32.min + 1, byDegrees: 1))
		XCTAssertTrue(UInt32.min.separates(from: UInt32.min + 1, byDegrees: 1))
		XCTAssertTrue(Int64.min.separates(from: Int64.min + 1, byDegrees: 1))
		XCTAssertTrue(UInt64.min.separates(from: UInt64.min + 1, byDegrees: 1))
		XCTAssertTrue(Int.min.separates(from: Int.min + 1, byDegrees: 1))
		XCTAssertTrue(UInt.min.separates(from: UInt.min + 1, byDegrees: 1))
		
		XCTAssertTrue(Int8.max.separates(from: Int8.max, byDegrees: 0))
		XCTAssertTrue(UInt8.max.separates(from: UInt8.max, byDegrees: 0))
		XCTAssertTrue(Int16.max.separates(from: Int16.max, byDegrees: 0))
		XCTAssertTrue(UInt16.max.separates(from: UInt16.max, byDegrees: 0))
		XCTAssertTrue(Int32.max.separates(from: Int32.max, byDegrees: 0))
		XCTAssertTrue(UInt32.max.separates(from: UInt32.max, byDegrees: 0))
		XCTAssertTrue(Int64.max.separates(from: Int64.max, byDegrees: 0))
		XCTAssertTrue(UInt64.max.separates(from: UInt64.max, byDegrees: 0))
		XCTAssertTrue(Int.max.separates(from: Int.max, byDegrees: 0))
		XCTAssertTrue(UInt.max.separates(from: UInt.max, byDegrees: 0))
		
		XCTAssertTrue(Int8.max.separates(from: Int8.max - 1, byDegrees: 1))
		XCTAssertTrue(UInt8.max.separates(from: UInt8.max - 1, byDegrees: 1))
		XCTAssertTrue(Int16.max.separates(from: Int16.max - 1, byDegrees: 1))
		XCTAssertTrue(UInt16.max.separates(from: UInt16.max - 1, byDegrees: 1))
		XCTAssertTrue(Int32.max.separates(from: Int32.max - 1, byDegrees: 1))
		XCTAssertTrue(UInt32.max.separates(from: UInt32.max - 1, byDegrees: 1))
		XCTAssertTrue(Int64.max.separates(from: Int64.max - 1, byDegrees: 1))
		XCTAssertTrue(UInt64.max.separates(from: UInt64.max - 1, byDegrees: 1))
		XCTAssertTrue(Int.max.separates(from: Int.max - 1, byDegrees: 1))
		XCTAssertTrue(UInt.max.separates(from: UInt.max - 1, byDegrees: 1))
		
		XCTAssertFalse(Int8.min.separates(from: Int8.max, byDegrees: 0))
		XCTAssertFalse(UInt8.min.separates(from: UInt8.max, byDegrees: 1))
		XCTAssertFalse(Int16.min.separates(from: Int16.max, byDegrees: 2))
		XCTAssertFalse(UInt16.min.separates(from: UInt16.max, byDegrees: 3))
		XCTAssertFalse(Int32.min.separates(from: Int32.max, byDegrees: 4))
		XCTAssertFalse(UInt32.min.separates(from: UInt32.max, byDegrees: 5))
		XCTAssertFalse(Int64.min.separates(from: Int64.max, byDegrees: 6))
		XCTAssertFalse(UInt64.min.separates(from: UInt64.max, byDegrees: 7))
		XCTAssertFalse(Int.min.separates(from: Int.max, byDegrees: 8))
		XCTAssertFalse(UInt.min.separates(from: UInt.max, byDegrees: 9))
		
		XCTAssertTrue(Int8.min.separates(from: -1, byDegrees: Int(Int8.max)))
		XCTAssertTrue(Int16.min.separates(from: -1, byDegrees: Int(Int16.max)))
		XCTAssertTrue(Int32.min.separates(from: -1, byDegrees: Int(Int32.max)))
		if Int.bitWidth >= 64 {
			XCTAssertTrue(Int64.min.separates(from: -1, byDegrees: Int(Int64.max)))
		}
		XCTAssertTrue(Int.min.separates(from: -1, byDegrees: Int.max))
		
		XCTAssertTrue(Int8.max.separates(from: 0, byDegrees: Int(Int8.max)))
		XCTAssertTrue(Int16.max.separates(from: 0, byDegrees: Int(Int16.max)))
		XCTAssertTrue(Int32.max.separates(from: 0, byDegrees: Int(Int32.max)))
		if Int.bitWidth >= 64 {
			XCTAssertTrue(Int64.max.separates(from: 0, byDegrees: Int(Int64.max)))
		}
		XCTAssertTrue(Int.max.separates(from: 0, byDegrees: Int.max))
		
		XCTAssertTrue(UInt8.min.separates(from: UInt8.max, byDegrees: Int(UInt8.max)))
		XCTAssertTrue(UInt16.min.separates(from: UInt16.max, byDegrees: Int(UInt16.max)))
		if Int.bitWidth >= 33 {
			XCTAssertTrue(UInt32.min.separates(from: UInt32.max, byDegrees: Int(UInt32.max)))
		}
		
	}
	
	///	Checks that `Countable`'s default unspecialised implementation is correct.
	func testDefaultCountability() {
		
		///	Measurement of achievement in a course.
		enum Grade: Int, CaseIterable, Countable {
			
			///	Outstanding grade.
			case a = 1
			///	Decent grade.
			case b = 2
			///	Sub-par grade.
			case c = 3
			///	Passing grade.
			case d = 4
			///	Failing grade.
			case f = 5
			
			//	MARK: Comparable Conformance
			static func < (lhs: Self, rhs: Self) -> Bool {
				lhs.rawValue > rhs.rawValue
			}
			
			//	This is necessary because otherwise `Strideable` uses `distance(to:)` for `==`
			static func == (lhs: Self, rhs: Self) -> Bool {
				lhs.rawValue == rhs.rawValue
			}
			
			///	A type that represents the distance between two grades.
			typealias Stride = Int
			
			///	Returns the distance from this grade to the given grade, expressed as a stride.
			///	- Parameter other: The grade to calculate the distance to.
			///	- Returns: The distance from this grade to `other`.
			func distance(to other: Self) -> Stride {
				other.rawValue - self.rawValue
			}
			
			///	Returns a grade that is offset the specified distance from this grade.
			///	- Parameter n: The distance to advance this grade.
			///	- Returns: A grade that is offset from this grade by `n`.
			func advanced(by n: Stride) -> Self {
				Self(rawValue: self.rawValue + n)!
			}
			
		}
		
		XCTAssertEqual(Grade.instance(immediatelyPreceding: .b), .a)
		XCTAssertNotEqual(Grade.instance(immediatelyPreceding: .b), .c)
		
		XCTAssertEqual(Grade.instance(immediatelySucceeding: .b), .c)
		XCTAssertNotEqual(Grade.instance(immediatelySucceeding: .c), .f)
		
		XCTAssertEqual(Grade.f.immediatePredecessor, .d)
		XCTAssertNotEqual(Grade.f.immediatePredecessor, .a)
		
		XCTAssertEqual(Grade.a.immediateSuccessor, .b)
		XCTAssertNotEqual(Grade.a.immediateSuccessor, .c)
		
		XCTAssertTrue(Grade.a.immediatelyPrecedes(.b))
		XCTAssertFalse(Grade.a.immediatelyPrecedes(.f))
		
		XCTAssertTrue(Grade.f.immediatelySucceeds(.d))
		XCTAssertFalse(Grade.f.immediatelySucceeds(.c))
		
		XCTAssertTrue(Grade.b.borders(on: .c))
		XCTAssertFalse(Grade.a.borders(on: .f))
		
		XCTAssertTrue(Grade.b.sharesCommonNeighbor(with: .d))
		XCTAssertTrue(Grade.b.sharesCommonNeighbor(with: .b))
		XCTAssertFalse(Grade.b.sharesCommonNeighbor(with: .a))
		
		XCTAssertTrue(Grade.a.separates(from: .a, byDegrees: 0))
		XCTAssertTrue(Grade.a.separates(from: .b, byDegrees: 1))
		XCTAssertFalse(Grade.a.separates(from: .f, byDegrees: 3))
		
	}
	
}
