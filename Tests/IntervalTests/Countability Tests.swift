//
//	Countability Tests.swift - Test cases and methods regarding types' coutabilities.
//
//	Created by Wowbagger & His Liquid Lunch on 20-08-10.
//

import XCTest
@testable import Interval

///	A group of test cases regarding types' coutabilities.
final class CountabilityTests: XCTestCase {
	
	///	The collection of degrees of separation for testing countinuity of uncountable types.
	///
	///	Members of the collection are designed to test edge cases for different bit-widths, such as `111`, `1000`, etc.
	lazy var collectionOfDegreesOfSeparation: Set<Int> = {
		var setOfInt: Set<Int> = [0, .max]
		var power = Int.max
		var exponent = Int.bitWidth / 2
		repeat {
			power >>= exponent
			exponent /= 2
			setOfInt.insert(power)
			setOfInt.insert(power + 1)
			
		} while exponent > 0
		return setOfInt
	}()
	
	///	Checks that instances of uncountable types behave as if they are continuous.
	func testContinuityOfUncountableTypes() {
		
		///	The collection `Double` values for testing `Double`'s continuity.
		let valuesOfTypeDouble: [Double] = [-1, 0, .leastNonzeroMagnitude, 0.5, 1, 2, .pi, .greatestFiniteMagnitude, .infinity]
		///	The collection `String` values for testing `String`'s continuity.
		let valuesOfTypeString: [String] = ["a", "b", "ç", "π", "the", "internet", "is", "made", "of", "cats"]
		
		valuesOfTypeDouble.forEach { doubleValue1 in
			valuesOfTypeDouble.forEach { doubleValue2 in
				XCTAssertFalse(
					doubleValue1.borders(on: doubleValue2),
					"A real number can never be found to border on another real number."
				)
				XCTAssertEqual(
					doubleValue1.sharesCommonNeighbor(with: doubleValue2),
					doubleValue1 == doubleValue2,
					"Real numbers \(doubleValue1) and \(doubleValue2) should\(doubleValue1 == doubleValue2 ? "" : " not ") share common neighbours."
				)
			}
		}
		
		valuesOfTypeString.forEach { stringValue1 in
			valuesOfTypeString.forEach { stringValue2 in
				XCTAssertFalse(
					stringValue1.borders(on: stringValue2),
					"A string can never be found to border on another string."
				)
				XCTAssertEqual(
					stringValue1.sharesCommonNeighbor(with: stringValue2),
					stringValue1 == stringValue2,
					"Strings \(stringValue1) and \(stringValue2) should\(stringValue1 == stringValue2 ? "" : " not ") share common neighbours."
				)
			}
		}
		
	}
	
	///	Checks that fixed-width integer types behave like countable sets.
	func testCountabilityOfFixedWidthIntrgers() {
		
		///	The collection of `UInt` values for testing `UInt`'s countability.
		let valuesOfTypeUInt: [UInt] = [.min, 0, 1, 2, 3, .max]
		///	The collection of `Int` values for testing `Int`'s countability.
		let valuesOfTypeInt: [Int] = [.min, -1, 0, 1, 2, .max]
		///	The collection of `UInt64` values for testing `UInt64`'s countability.
		let valuesOfTypeUInt64: [UInt64] = [.min, 0, 1, 2, 3, .max]
		///	The collection of `Int64` values for testing `Int64`'s countability.
		let valuesOfTypeInt64: [Int64] = [.min, -1, 0, 1, 2, .max]
		///	The collection of `UInt32` values for testing `UInt32`'s countability.
		let valuesOfTypeUInt32: [UInt32] = [.min, 0, 1, 2, 3, .max]
		///	The collection of `Int32` values for testing `Int32`'s countability.
		let valuesOfTypeInt32: [Int32] = [.min, -1, 0, 1, 2, .max]
		///	The collection of `UInt16` values for testing `UInt16`'s countability.
		let valuesOfTypeUInt16: [UInt16] = [.min, 0, 1, 2, 3, .max]
		///	The collection of `Int16` values for testing `Int16`'s countability.
		let valuesOfTypeInt16: [Int16] = [.min, -1, 0, 1, 2, .max]
		///	The collection of `UInt8` values for testing `UInt8`'s countability.
		let valuesOfTypeUInt8: [UInt8] = [.min, 0, 1, 2, 3, .max]
		///	The collection of `Int8` values for testing `Int8`'s countability.
		let valuesOfTypeInt8: [Int8] = [.min, -1, 0, 1, 2, .max]
		
		//	TODO: Find a way not to include `Countable` as `T`'s constraint.
		
		///	Checks that fixed-width integer types behave like countable sets, by checking the given subset of integers.
		///	- Parameter integers: The given subset of integers.
		func testCountabilityOfFixedWidthIntrgers<T: Countable & FixedWidthInteger>(inSubset integers: [T]) where T.Stride == Int {
			
			integers.forEach { integer1 in
				
				if integer1 > T.min {
					XCTAssertEqual(
						T.instance(immediatelyPreceding: integer1),
						integer1 - 1,
						"\(T.isSigned ? "S" : "Uns")inged \(T.bitWidth)-bit integer \(integer1) should be immediately preceded by \(integer1 - 1)."
					)
					XCTAssertEqual(
						integer1.immediatePredecessor,
						integer1 - 1,
						"\(T.isSigned ? "S" : "Uns")inged \(T.bitWidth)-bit integer \(integer1) should be immediately preceded by \(integer1 - 1)."
					)
				}
				
				if integer1 < T.max {
					XCTAssertEqual(
						T.instance(immediatelySucceeding: integer1),
						integer1 + 1,
						"\(T.isSigned ? "S" : "Uns")inged \(T.bitWidth)-bit integer \(integer1) should be immediately succeeded by \(integer1 + 1)."
					)
					XCTAssertEqual(
						integer1.immediateSuccessor,
						integer1 + 1,
						"\(T.isSigned ? "S" : "Uns")inged \(T.bitWidth)-bit integer \(integer1) should be immediately succeeded by \(integer1 + 1)."
					)
				}
				
				integers.forEach { integer2 in
					
					let integersAreNeighbours = integer1 != integer2 && max(integer1, integer2) == min(integer1, integer2).advanced(by: 1)
					
					XCTAssertEqual(
						integer1.borders(on: integer2),
						integersAreNeighbours,
						"\(T.isSigned ? "S" : "Uns")inged \(T.bitWidth)-bit integers \(integer1) and \(integer2) should\(integersAreNeighbours ? "": " not ") be neighbours."
					)
					
					var integersShareCommonNeighbours: Bool {
						if integer1 == integer2 { return true }
						
						let (partialInteger2, operation1Overflows) = integer1.addingReportingOverflow(2)
						if !operation1Overflows && partialInteger2 == integer2 { return true }
						
						let (partialInteger1, operation2Overflows) = integer2.addingReportingOverflow(2)
						if !operation2Overflows && partialInteger1 == integer1 { return true }
						
						return false
					}
					
					XCTAssertEqual(
						integer1.sharesCommonNeighbor(with: integer2),
						integersShareCommonNeighbours,
						"\(T.isSigned ? "S" : "Uns")inged \(T.bitWidth)-bit integers \(integer1) and \(integer2) should\(integersShareCommonNeighbours ? "": " not ") share common neighbours."
					)
					
					collectionOfDegreesOfSeparation.forEach { degrees in
						guard degrees >= 0 else {
							XCTFail("`degrees` must be a natural number.")
							return
						}
						
						var integersAreSeparatedByDegrees: Bool {
							
//							var lowerInteger = min(integer1, integer2)
//							let higherInteger = max(integer1, integer2)
//
//							var degrees = degrees
//
//							repeat {
//								if lowerInteger == higherInteger { return degrees == 0 }
//								if degrees == 0 { return false }
//								lowerInteger = lowerInteger.advanced(by: 1)
//								degrees -= 1
//							} while lowerInteger <= higherInteger
//
//							return false
							
							if T.bitWidth < T.Stride.bitWidth {
								return abs(integer1.distance(to: integer2)) == degrees
							} else {
								let lowerInteger = min(integer1, integer2)
								let higherInteger = max(integer1, integer2)
								
								let degrees = T(exactly: degrees)
								
								let (partialDistance, overflow) = higherInteger.subtractingReportingOverflow(lowerInteger)
								
								return !overflow && partialDistance == degrees
							}
							
						}
						
						XCTAssertEqual(
							integer1.separates(from: integer2, byDegrees: degrees),
							integersAreSeparatedByDegrees,
							"\(T.isSigned ? "S" : "Uns")inged \(T.bitWidth)-bit integers \(integer1) and \(integer2) should\(integersAreSeparatedByDegrees ? "": " not ") be separated by \(degrees) degree\(degrees == 1 ? "s" : "")."
						)
						
					}
					
				}
				
			}
			
		}
		
		testCountabilityOfFixedWidthIntrgers(inSubset: valuesOfTypeUInt)
		testCountabilityOfFixedWidthIntrgers(inSubset: valuesOfTypeInt)
		testCountabilityOfFixedWidthIntrgers(inSubset: valuesOfTypeUInt64)
		testCountabilityOfFixedWidthIntrgers(inSubset: valuesOfTypeInt64)
		testCountabilityOfFixedWidthIntrgers(inSubset: valuesOfTypeUInt32)
		testCountabilityOfFixedWidthIntrgers(inSubset: valuesOfTypeInt32)
		testCountabilityOfFixedWidthIntrgers(inSubset: valuesOfTypeUInt16)
		testCountabilityOfFixedWidthIntrgers(inSubset: valuesOfTypeInt16)
		testCountabilityOfFixedWidthIntrgers(inSubset: valuesOfTypeUInt8)
		testCountabilityOfFixedWidthIntrgers(inSubset: valuesOfTypeInt8)
		
	}
	
	//	FIXME: Fix `testDefaultImplementationOfCountable()`.
	
	///	Checks that the default implementation of Countable is correct.
	private func testDefaultImplementationOfCountable() {
		
		///	Standardised measurement of achievement in a course.
		enum Grade: String, CaseIterable, Countable {
			
			///	Outstanding grade.
			case a = "A"
			///	Decent grade.
			case b = "B"
			///	Sub-par grade.
			case c = "C"
			///	Passing grade.
			case d = "D"
			///	Failing grade.
			case f = "F"
			
			//	MARK: CaseIterable Conformance
			
			typealias AllCases = [Self]
			
			static var allCases: [Self] = [.a, .b, .c, .d, .f]
			
			//	MARK: Comparable Conformance
			static func < (lhs: Self, rhs: Self) -> Bool {
				return lhs.rawValue > rhs.rawValue
			}
			
			//	This is necessary because otherwise `Strideable` uses `distance(to:)` for `==`
			static func == (lhs: Self, rhs: Self) -> Bool {
				return lhs.rawValue == rhs.rawValue
			}
			
			///	A type that represents the distance between two grades.
			typealias Stride = Int

			///	Returns the distance from this grade to the given grade, expressed as a stride.
			///	- Parameter other: The grade to calculate the distance to.
			///	- Returns: The distance from this grade to `other`.
			func distance(to other: Self) -> Stride {
				let sortedGrades = Self.allCases.sorted()
				let otherIndex = sortedGrades.firstIndex(of: other)!
				let selfIndex = sortedGrades.firstIndex(of: self)!
				return abs(selfIndex - otherIndex)
			}
			
			///	Returns a grade that is offset the specified distance from this grade.
			///	- Parameter n: The distance to advance this grade.
			///	- Returns: A grade that is offset from this grade by `n`.
			func advanced(by n: Stride) -> Self {
				let sortedGrades = Self.allCases.sorted(by: <)
				let selfIndex = sortedGrades.firstIndex(of: self)!
				return sortedGrades[selfIndex + n]
			}
			
			///	Returns the grade that immediately precedes the given grade.
			///	- Precondition: `grade < .a`.
			///	- Parameter grade: The given grade.
			///	- Returns: The value that immediately precedes the given grade.
			static func instance(immediatelyPreceding grade: Self) -> Self {
				precondition(grade < .a, "Grade can not be A.")
				let sortedGrades = Self.allCases.sorted(by: >)
				let gradeIndex = sortedGrades.firstIndex(of: grade)!
				return sortedGrades[gradeIndex - 1]
			}
			
			///	Returns the grade that immediately succeedes the given grade.
			///	- Precondition: `grade > .f`.
			///	- Parameter grade: The given grade.
			///	- Returns: The value that immediately succeedes the given grade.
			static func instance(immediatelySucceeding grade: Self) -> Self {
				precondition(grade > .f, "Grade can not be F.")
				let sortedGrades = Self.allCases.sorted(by: >)
				let gradeIndex = sortedGrades.firstIndex(of: grade)!
				return sortedGrades[gradeIndex + 1]
			}
			
		}
		
		Grade.allCases.forEach { grade1 in
			
			if grade1 != .a {
				let oneHigherGrade: Grade = {
					let sortedGrades = Grade.allCases.sorted(by: >)
					let grade1Index = sortedGrades.firstIndex(of: grade1)!
					return sortedGrades[grade1Index - 1]
				}()
				
				XCTAssertEqual(
					Grade.instance(immediatelyPreceding: grade1),
					oneHigherGrade,
					"Grade \(grade1) should be immediately preceded by \(oneHigherGrade)."
				)
				XCTAssertEqual(
					grade1.immediatePredecessor,
					oneHigherGrade,
					"Grade \(grade1) should be immediately preceded by \(oneHigherGrade)."
				)
			}
			
			if grade1 != .f {
				let oneLowerGrade: Grade = {
					let sortedGrades = Grade.allCases.sorted(by: >)
					let grade1Index = sortedGrades.firstIndex(of: grade1)!
					return sortedGrades[grade1Index + 1]
				}()
				
				XCTAssertEqual(
					Grade.instance(immediatelySucceeding: grade1),
					oneLowerGrade,
					"Grade \(grade1) should be immediately succeeded by \(oneLowerGrade)."
				)
				XCTAssertEqual(
					grade1.immediateSuccessor,
					oneLowerGrade,
					"Grade \(grade1) should be immediately succeeded by \(oneLowerGrade)."
				)
			}
			
			Grade.allCases.forEach { grade2 in
				
				let gradesAreNeighbours: Bool = {
					let sortedGrades = Grade.allCases.sorted()
					let grade1Index = sortedGrades.firstIndex(of: grade1)!
					let grade2Index = sortedGrades.firstIndex(of: grade2)!
					return abs(grade1Index - grade2Index) == 1
				}()
				
				XCTAssertEqual(
					grade1.borders(on: grade2),
					gradesAreNeighbours,
					"Grrades \(grade1) and \(grade2) should\(gradesAreNeighbours ? "": " not ") be neighbours."
				)
				
				let gradesShareNeighbours: Bool = {
					if grade1 == grade2 { return true }
					let sortedGrades = Grade.allCases.sorted()
					let grade1Index = sortedGrades.firstIndex(of: grade1)!
					let grade2Index = sortedGrades.firstIndex(of: grade2)!
					return abs(grade1Index - grade2Index) == 2
				}()
				
				XCTAssertEqual(
					grade1.sharesCommonNeighbor(with: grade2),
					gradesShareNeighbours,
					"Grrades \(grade1) and \(grade2) should\(gradesAreNeighbours ? "": " not ") share common neighbours."
				)
				
				collectionOfDegreesOfSeparation.forEach { degrees in
					
					let gradesAreSeparatedByDegrees: Bool = {
						let sortedGrades = Grade.allCases.sorted()
						let grade1Index = sortedGrades.firstIndex(of: grade1)!
						let grade2Index = sortedGrades.firstIndex(of: grade2)!
						return abs(grade1Index - grade2Index) == degrees
					}()
					
					XCTAssertEqual(
						grade1.separates(from: grade2, byDegrees: degrees),
						gradesAreSeparatedByDegrees,
						"Grrades \(grade1) and \(grade2) should\(gradesAreSeparatedByDegrees ? "": " not ") be separated by \(degrees) degree\(degrees == 1 ? "s" : "")."
					)
					
				}
				
			}
			
		}
		
	}
	
}
