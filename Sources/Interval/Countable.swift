//
//	Countable.swift - The Countable protocol and countable types.
//
//	Created by Wowbagger & His Liquid Lunch on 20-08-21.
//

///	This file defines and provides default implementation for `Countable`, and conforms `BinaryInteger` types in the standard library to it.

//

///	A type representing members of a countable set.
///
///	By definition, a set 𝑆 is countable if and only if each member of 𝑆 can be mapped to a distinct natural number without running out of all natural numbers, i.e. symbolically, iff ∀𝑠 ∈ 𝑆, ∃𝑛 ∈ ℕ, 𝑓(𝑛) = 𝑠. If a type can be considered as a set of all its possible instance values, then `T` is countable if and only if there exists a function `f` that takes a natural number`n` as its only argument, where the set of all possible `f(n)` equals to the set of all possible values of `T`. In pseudocode,
///
///	```swift
///	///	Maps a value `x` of type `X` to a value `y` of type `Y`.
///	func f<X, Y>(x: X) -> Y { /* ... */ }
///
///	///	Generates a set of all possible values of type `S`.
///	func allPossibleValues<S>(_ type: S.type) -> Set<S> { /* ... */ }
///
///	///	The set of all possible values of type `T`.
///	let allPossibleValuesOfT: Set<T> = allPossibleValues(of: T.self)
///
///	///	The set of all natural numbers.
///	let allNaturalNumbers: Set<ℕ> = allPossibleValues(of: ℕ.self)
///
///	///	The set of all possible values of `T` mapped From natural numbers.
///	let valuesOfTMappedFromNaturalNumbers: Set<T> = Set(
///		allNaturalNumbers.map { n in f(n) }
///	)
///
///	if allPossibleValuesOfT = valuesOfTMappedToNaturalNumbers {
///		//	T is countable.
///	} else {
///		//	T is uncountable.
///	}
///	```
///
///	In the pseudocode above, there is no possible implementation for function `allPossibleValues` that can generate `allNaturalNumbers`. This is because the `count` of every `Set` instance is restricted by the finite size of `Set.Index`, that of `Int`, and that of physical memory available. The same size restriction exists for all Swift types, not just `Set.Index` and `Int`, which in practice renders all types as sets of binary sequences of fixed-lengths. Because all such sets are countable, one might be inclined to consider all Swift types countable. However, in general use cases, physically restrictions are often ignored, and types are treated as perfect representations of the mathematical concepts they intend to model. For example, although `Double` is constrained to a fixed size of 64 bits, with all its instances having finite precisions and together forming a subset of rational numbers, it intends to model the entire set of real numbers, as indicated by its static properties such as `Double.pi` and `Double.infinity`. Because the set of all real numbers is uncountable, `Double` is uncountable.
///
///	Most Swift types such as `String` and `[Int]` can be proven uncountable by either a surjective mapping to `Double`, or by Cantor's diagonal argument. A simplified general rule of thumb to finding a type `T`'s countability, without going through a rigorous mathematical proof, is answering this question: "If given an arbitrary instance of the type `T`, can one reasonably deduce the next in line with a stable algorithm?" If the answer is yes, then the type is countable, otherwise uncountable.
///
///	Currently, as of Swift 5.2, among types defined in the standard library, only `BinaryInteger`-conforming types, `Void`, and `Never` are countable by the rules listed above. However, only `BinaryInteger`-conforming types conform to `Countable`. `Void` can not conform to `Countable` because tuples can not be extended. `Never` can not conform to `Countable` because the type is uninhabited, i.e. ∅.
///
///	Conforming to the Countable Protocol
///	====================================
///
///	If you If you create a custom type that conceptually models a countable set, make sure that it conforms to the `Countable` protocol in order to give a more useful and more efficient interface for operations such as calculating proximity between values. To add `Countable` conformance to your type, you must declare at least the `instance(immediatelyPreceding)` and `instance(immediatelySucceeding)` static functions. In addition, you must ensure that for all the type's instances, both `self.borders(on: self.immediatePredecessor)` and `self.borders(on: self.immediateSuccessor)` must evaluate to `true`.
///
///	- Warning: The default implementation of `Countable` is untested, due to a problem with the test case.
///
///	- ToDo: Fix the test case for the default implementation.
///
///	- SeeAlso: Relevant [discussion](https://forums.swift.org/t/countable-types/39593) on the Swift forums.
public protocol Countable: Strideable where Stride: BinaryInteger {
	///	Returns the value that immediately precedes the given value.
	///	- Parameter value: The given value.
	///	- Returns: The value that immediately precedes the given value, with all possible values of type `Self` ordered ascending by their mapped natural numbers. It can be the greatest value less than `self`, but it doesn't have to be.
	@inlinable
	static func instance(immediatelyPreceding value: Self) -> Self
	
	///	Returns the value that immediately succeeds the given value.
	///	- Parameter value: The given value.
	///	- Returns: The value that immediately succeeds the given value, with all possible values of type `Self` ordered ascending by their mapped natural numbers. It can be the least value greater than `self`, but it doesn't have to be.
	@inlinable
	static func instance(immediatelySucceeding value: Self) -> Self
	
	///	The value that immediately precedes the current value.
	///
	///	The value is the one that immediately precedes the current value, with all possible values of type `Self` ordered ascending by their mapped natural numbers. It can be the greatest value less than `self`, but it doesn't have to be.
	@inlinable
	var immediatePredecessor: Self { get }
	
	///	The value that immediately succeeds the current value.
	///
	///	The value is the one that immediately succeeds the current value, with all possible values of type `Self` ordered ascending by their mapped natural numbers. It can be the least value greater than `self`, but it doesn't have to be.
	@inlinable
	var immediateSuccessor: Self { get }
	
	///	Inspects if this value immediately precedes the given other value.
	///	- Parameter other: The other value.
	@inlinable
	func immediatelyPrecedes(_ other: Self) -> Bool
	
	///	Inspects if this value immediately succeeds the given other value.
	///	- Parameter other: The other value.
	@inlinable
	func immediatelySucceeds(_ other: Self) -> Bool
	
	///	Inspects if this value is right next to the given other value.
	///	- Requires: Both `self.borders(on: self.immediatePredecessor)` and `self.borders(on: self.immediateSuccessor)` must evaluate to `true`.
	///	- Parameter other: The given other value.
	///	- Returns: `true` if the 2 values are right next to each other, `false` otherwise.
	@inlinable
	func borders(on other: Self) -> Bool
	
	///	Inspects if this value shares a common neighbor with the given other value.
	///	- Note: The 2 values could be equal, if the function returns true.
	///	- Parameter other: The given other value.
	///	- Returns: `true` if the 2 values are both right next to a 3rd value, `false` otherwise.
	@inlinable
	func sharesCommonNeighbor(with other: Self) -> Bool
	
	///	Inspects the correctness of the Bacon number (or, degrees of separation) between this value and the given other value.
	///	- Parameters:
	///	  - other: The given other value.
	///	  - degrees: The Bacon number.
	///	- Returns: `true` if the Bacon number is correct, `false` otherwise.
	@inlinable
	func separates(from other: Self, byDegrees degrees: Stride) -> Bool
}

extension Countable {
	///	The value that immediately precedes the current value.
	///
	///	The value is the one that immediately precedes the current value, with all possible values of type `Self` ordered ascending by their mapped natural numbers. It can be the greatest value less than `self`, but it doesn't have to be.
	@inlinable
	public var immediatePredecessor: Self {
		Self.instance(immediatelyPreceding: self)
	}
	
	///	The value that immediately succeeds the current value.
	///
	///	The value is the one that immediately succeeds the current value, with all possible values of type `Self` ordered ascending by their mapped natural numbers. It can be the least value greater than `self`, but it doesn't have to be.
	@inlinable
	public var immediateSuccessor: Self {
		Self.instance(immediatelySucceeding: self)
	}
	
	///	Inspects if this value immediately precedes the given other value.
	///	- Parameter other: The other value.
	@inlinable
	public func immediatelyPrecedes(_ other: Self) -> Bool {
		self < other && self.borders(on: other)
	}
	
	///	Inspects if this value immediately succeeds the given other value.
	///	- Parameter other: The other value.
	@inlinable
	public func immediatelySucceeds(_ other: Self) -> Bool {
		other.immediatelyPrecedes(self)
	}
	
	///	Inspects if this value is right next to the given other value.
	///	- Requires: Both `self.borders(on: self.immediatePredecessor)` and `self.borders(on: self.immediateSuccessor)` must evaluate to `true`.
	///	- Parameter other: The given other value.
	///	- Returns: `true` if the 2 values are right next to each other, `false` otherwise.
	@inlinable
	public func borders(on other: Self) -> Bool {
		self.separates(from: other, byDegrees: 1)
	}
	
	///	Inspects if this value shares a common neighbor with the given other value.
	///	- Parameter other: The given other value.
	///	- Returns: `true` if the 2 values are both right next to a 3rd value, `false` otherwise.
	///	- Note: The 2 values could be equal, if the function returns true.
	@inlinable
	public func sharesCommonNeighbor(with other: Self) -> Bool {
		self.separates(from: other, byDegrees: 2) || self == other
	}
	
	//	The current implementation of this method is provided by [cukr](https://forums.swift.org/t/negotiate-between-max-stride-size-and-max-distance/39559/5) on the Swift Forums.
	
	///	Inspects the correctness of the Bacon number (or, degrees of separation) between this value and the given other value.
	///
	///	If `Self` conforms to `BinaryInteger`, then in most cases, `self.separates(from: other, byDegrees: degrees)` is equivalent to `Stride(max(self, other) - min(self, other)) == degrees`. However, the equivalence breaks when `Self.min.distance(to: Self.max)` is greater than `Stride.max`, i.e. when the maximal distance between `self` and `other` is too large for `Stride` to represent.
	///
	///	- Precondition: `degrees >= 0`.
	///
	///	- Complexity: O(_n_), where _n_ is either the largest possible distance between `self` and `other` or the largest possible value of `degrees`, whichever is greater.
	///
	///	  Because of the linear time complexity, conforming types should provide their own implementations with lower time complexities, when there is only the possibility of overflow up (when `degrees` is greater than `Self.max - self` or `Self.max - other`) or that of overflow down (when `Self.max - Self.min` is greater than `Stride.max`). For example, this is a rather straightforward custom implementation of this method for `UInt8`:
	///
	///	  ```swift
	///	  func separates(from other: UInt8, byDegrees degrees: Int) -> Bool {
	///	      precondition(degrees >= 0, "`degrees` must be a natural number.")
	///	      return abs(self.distance(to: other)) == degrees
	///	  }
	///	  ```
	///
	///	- Warning: The default implementation of this instance method is untested, due to a problem with the test case.
	///	
	///	- ToDo: Fix the test case for the default implementation.
	///
	///	- Parameters:
	///	  - other: The given other value.
	///	  - degrees: The Bacon number.
	///
	///	- Returns: `true` if the Bacon number is correct, `false` otherwise.
	@inlinable
	public func separates(from other: Self, byDegrees degrees: Stride) -> Bool {
		precondition(degrees >= 0, "`degrees` must be a natural number.")
		
		var lowerValue = min(self, other)
		let higherValue = max(self, other)
		
		var degrees = degrees
		
		repeat {
			if lowerValue == higherValue {
				return degrees == 0
			}
			if degrees == 0 {
				return false
			}
			lowerValue = lowerValue.advanced(by: 1)
			degrees -= 1
		} while lowerValue <= higherValue
		
		return false
	}
}

//	MARK: - Countable Conformance for Standard Library Types

extension Countable where Self: BinaryInteger {
	///	Returns the value less than the given value by 1.
	///	- Warning: If `Self` has a lowest representable value, use the implementation specialised for `Countable where Self: FixedWidthInteger`. Calling this static method with the lowest representable value of `Self` as `value` triggers an integer overflow, which will be trapped and reported as a runtime error.
	///	- Warning: Only the implementation specialised for `FixedWidthInteger` has been tested.
	///	- Parameter value: The given other value.
	///	- Returns: `value - 1`.
	@inlinable
	public static func instance(immediatelyPreceding value: Self) -> Self {
		value - 1
	}
	
	///	Returns the value greater than the given value by 1.
	///	- Warning: If `Self` has a highest representable value, use the implementation specialised for `Countable where Self: FixedWidthInteger`. Calling this static method with the highest representable value of `Self` as `value` triggers an integer overflow, which will be trapped and reported as a runtime error.
	///	- Warning: Only the implementation specialised for `FixedWidthInteger` has been tested.
	///	- Parameter value: The given other value.
	///	- Returns: `value + 1`.
	@inlinable
	public static func instance(immediatelySucceeding value: Self) -> Self {
		value + 1
	}
}

extension Countable where Self: FixedWidthInteger {
	///	Returns the value less than the given value by 1.
	///	- Precondition: `value > Self.min`.
	///	- Parameter value: The given other value.
	///	- Returns: `value - 1`.
	@inlinable
	public static func instance(immediatelyPreceding value: Self) -> Self {
		precondition(value > Self.min, "Parameter `value` must be greater than `Self.min`.")
		return value - 1
	}
	
	///	Returns the value greater than the given value by 1.
	///	- Precondition: `value < Self.max`.
	///	- Parameter value: The given other value.
	///	- Returns: `value + 1`.
	@inlinable
	public static func instance(immediatelySucceeding value: Self) -> Self {
		precondition(value < Self.max, "Parameter `value` must be less than `Self.max`.")
		return value + 1
	}
	
	///	Inspects the correctness of the Bacon number (or, degrees of separation) between this integer and the given other integer.
	///
	///	- Precondition: `degrees >= 0`.
	///
	///	- Complexity: O(1).
	///
	///	- Parameters:
	///	  - other: The given other value.
	///	  - degrees: The Bacon number.
	///
	///	- Returns: `true` if the Bacon number is correct, `false` otherwise.
	@inlinable
	public func separates(from other: Self, byDegrees degrees: Stride) -> Bool {
		precondition(degrees >= 0, "`degrees` must be a natural number.")
		
		//	Stride is implied to be SignedInteger.
		
		if Self.bitWidth < Stride.bitWidth {
			return abs(self.distance(to: other)) == degrees
		} else {
			///	The less between `self` and `other`.
			let lowerValue = Swift.min(self, other)
			///	The greater between `self` and `other`.
			let higherValue = Swift.max(self, other)
			///	The Bacon number.
			///
			///	`degrees >= 0`, so it's fine if `Self` is unsigned.
			let degrees = Self(exactly: degrees)
			
			let (partialDistance, overflow) = higherValue.subtractingReportingOverflow(lowerValue)
			
			return !overflow && partialDistance == degrees
		}
	}
}

extension Countable where Self: FixedWidthInteger & UnsignedInteger {
	///	Inspects the correctness of the Bacon number (or, degrees of separation) between this unsigned integer and the given other unsigned integer.
	///
	///	- Precondition: `degrees >= 0`.
	///
	///	- Complexity: O(1).
	///
	///	- Parameters:
	///	  - other: The given other value.
	///	  - degrees: The Bacon number.
	///
	///	- Returns: `true` if the Bacon number is correct, `false` otherwise.
	@inlinable
	public func separates(from other: Self, byDegrees degrees: Stride) -> Bool {
		precondition(degrees >= 0, "`degrees` must be a natural number.")
		
		//	`Self` is unsigned, so if there aren't enough bits in `Self` for `degrees`, then `self` can't possibly separate from `other` by `degrees`.
		guard let degrees = Self(exactly: degrees) else { return false }
		
		let lowerValue = Swift.min(self, other)
		let higherValue = Swift.max(self, other)
		
		let (partialHigherValue, operationOverflows) = lowerValue.addingReportingOverflow(degrees)
		
		return !operationOverflows && partialHigherValue == higherValue
	}
}

extension UInt: Countable {}
extension Int: Countable {}

extension UInt64: Countable {}
extension Int64: Countable {}

extension UInt32: Countable {}
extension Int32: Countable {}

extension UInt16: Countable {}
extension Int16: Countable {}

extension UInt8: Countable {}
extension Int8: Countable {}

//extension Never: Countable {
//	///	A type that represents the distance between two `Never` values.
//	public typealias Stride = Int
//
//	///	Returns the distance from this value to the given value, expressed as a stride.
//	///	- Warning: `Never` is uninhabited, so this function body should never have been executed.
//	///	- Parameter other: The value to calculate the distance to.
//	///	- Returns: The distance from this value to `other`.
//	@inlinable
//	public func distance(to other: Self) -> Int {
//		fatalError("`Never` is uninhabited, so this function body should never have been executed.")
//	}
//
//	///	Returns a value that is offset the specified distance from this value.
//	///	- Warning: `Never` is uninhabited, so this function body should never have been executed.
//	///	- Parameter n: The distance to advance this value.
//	///	- Returns: A value that is offset from this value by `n`.
//	@inlinable
//	public func advanced(by n: Stride) -> Self {
//		fatalError("`Never` is uninhabited, so this function body should never have been executed.")
//	}
//
//	///	Returns the value that immediately precedes the given value.
//	///	- Warning: `Never` is uninhabited, so this function body should never have been executed.
//	///	- Parameter value: The given value.
//	///	- Returns: The value that immediately precedes the given value, with all possible values of type `Never` ordered ascendingly by their mapped natural numbers. It can be the greatest value less than `Never`, but it doesn't have to be.
//	@inlinable
//	public static func instance(immediatelyPreceding value: Self) -> Self {
//		fatalError("`Never` is uninhabited, so this function body should never have been executed.")
//	}
//
//	///	Returns the value that immediately succeeds the given value.
//	///	- Warning: `Never` is uninhabited, so this function body should never have been executed.
//	///	- Parameter value: The given value.
//	///	- Returns: The value that immediately succeeds the given value, with all possible values of type `Never` ordered ascendingly by their mapped natural numbers. It can be the least value greater than `Never`, but it doesn't have to be.
//	@inlinable
//	public static func instance(immediatelySucceeding value: Self) -> Self {
//		fatalError("`Never` is uninhabited, so this function body should never have been executed.")
//	}
//
//	///	The value that immediately precedes the current value.
//	///
//	///	The value is the one that immediately precedes the current value, with all possible values of type `Never` ordered ascendingly by their mapped natural numbers. It can be the greatest value less than `self`, but it doesn't have to be.
//	///
//	///	- Warning: `Never` is uninhabited, so this function body should never have been executed.
//	@inlinable
//	public var immediatePredecessor: Self {
//		fatalError("`Never` is uninhabited, so this function body should never have been executed.")
//	}
//
//	///	The value that immediately succeeds the current value.
//	///
//	///	The value is the one that immediately succeeds the current value, with all possible values of type `Self` ordered ascendingly by their mapped natural numbers. It can be the least value greater than `self`, but it doesn't have to be.
//	///
//	///	- Warning: `Never` is uninhabited, so this function body should never have been executed.
//	@inlinable
//	public var immediateSuccessor: Self {
//		fatalError("`Never` is uninhabited, so this function body should never have been executed.")
//	}
//
//	///	Inspects if this value is right next to the given other value.
//	///	- Requires: Both `self.borders(on: self.immediatePredecessor)` and `self.borders(on: self.immediateSuccessor)` must evaluate to `true`.
//	///	- Warning: `Never` is uninhabited, so this function body should never have been executed.
//	///	- Parameter other: The given other value.
//	///	- Returns: `true` if the 2 values are right next to each other, `false` otherwise.
//	@inlinable
//	public func borders(on other: Self) -> Bool {
//		fatalError("`Never` is uninhabited, so this function body should never have been executed.")
//	}
//
//	///	Inspects if this value shares a common neighbour with the given other value.
//	///	- Warning: `Never` is uninhabited, so this function body should never have been executed.
//	///	- Parameter other: The given other value.
//	///	- Returns: `true` if the 2 values are both right next to a 3rd value, `false` otherwise.
//	///	- Note: The 2 values could be equal, if the function returns true.
//	@inlinable
//	public func sharesCommonNeighbor(with other: Self) -> Bool {
//		fatalError("`Never` is uninhabited, so this function body should never have been executed.")
//	}
//
//	///	Inspects the correctness of the Bacon number (or, degrees of separation) between this value and the given other value.
//	///	- Warning: `Never` is uninhabited, so this function body should never have been executed.
//	///	- Parameters:
//	///	  - other: The given other value.
//	///	  - degrees: The Bacon number.
//	///	- Returns: `true` if the Bacon number is correct, `false` otherwise.
//	@inlinable
//	public func separates(from other: Self, byDegrees degrees: Stride) -> Bool {
//		fatalError("`Never` is uninhabited, so this function body should never have been executed.")
//	}
//}
