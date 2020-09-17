//
//	Interval.swift - Unified and complete interval represenatation.
//
//	Created by Wowbagger & His Liquid Lunch on 20-07-18.
//

///	This file comtains the definitaion of the `Interval` generic struct, along with its extensions. Extensions of `IntervalMember` that closely relate to `Interval` are also contained within, but potentially will be moved into their own files.

//	TODO: Decide whether to allow closed unbounded intervals: [-∞, ∞], and up date the documentation if the decision is yes.
//	TODO: Update the entire documentation as the prototype progresses.

///	An interval.
///
///	An interval has a lower boundary and an upper boundary, and a lower endpoint and an upper endpoint. It represents a range, or a continuous set, of values of a `IntervalMember` type. Each boundary can be either closed or open (or, inclusive or exclusive), and each endpoint can be either bounded or unbounded. A closed boundary includes its corresponding endpoint in the interval, while an open boundary does not. A bounded endpoint provides a tangible boundary for the interval; an unbounded lower endpoint is equivalent to the abstract negative infinity, an unbounded upper endpoint the positive infinity. An unbounded endpoint always comes with an open boundary.
///
///	Defined by its boundries and endpoints, an interval can be empty, degenerate, or propper: An empty interval contains no members, a degenerate interval 1 and only 1 member, and a proper interval more than 1 member.
///
///	An interval whose `Member` conforms to the `Strideable` protocol is iterated in the inverse (descending) order, if `isInverse` is set to `true`. If `Member` doesn't conform to `Strideable`, then `isInverse` is accessible, but has no effects.
///
///	Equality Comparison
///	-------------------
///
///	When two intervals are compared for equality, only their boundaries and endpoints are considered; their iterating directions are ignored:
///
///	```swift
///	let interval1 = Interval(from: 0, to: 1, .inclusive, inInverseStridingDirection: false)
///	let interval2 = Interval(from: 0, to: 1, .inclusive, inInverseStridingDirection: true)
///	print(interval1 == interval2)	//	true
///	```
///
///	All empty intervals with the same `Member` type are equal; no empty interval is equal to any non-empty interval:
///
///	```swift
///	let interval3 = Interval(from: 0, to: 0, .exclusive)
///	let interval4 = Interval(from: 3, to: 2, .exclusive)
///	let interval5 = Interval(from: 0, to: 0, .inclusive)
///	print(interval3 == interval4)	//	true
///	print(interval3 == interval5)	//	false
///	```
///
///	- ToDo: Allow equality comparsions of different `Interval` types wherever comparison between their associated `Member` types is allowed:
///
///	  ```swift
///	  let intervalOfInts: Interval<Int> = Interval(from: 1, to: 9, .exclusive)
///	  let intervalOfUInts: Interval<UInt> = Interval(from: 1, to: 9, .exclusive)
///	  print(intervalOfInts == intervalOfUInts)	//	true
///	  ```
///
///	- SeeAlso: `IntervalMember` for additional design rationales.
public struct Interval<Member: IntervalMember> {
	
	//	MARK: - Supporting Types
	
	///	An endpoint's style, either bounded or unbounded.
	public enum Endpoint: Equatable {
		///	A bounded endpoint with a value of `Member` type.
		case bounded(_ value: Member)
		///	An unbounded endpoint.
		case unbounded
	}
	
	//	MARK: - Interval-Defining Properties
	
	///	The interval's lower boundary accessibility.
	public let lowerBoundaryAccessibility: IntervalBoundaryAccessibility
	
	///	The interval's upper boundary accessibility.
	public let upperBoundaryAccessibility: IntervalBoundaryAccessibility
	
	///	The interval's lower boundary availability.
	public var lowerBoundaryAvailability: IntervalBoundaryAvailability { .init(accessibility: lowerBoundaryAccessibility) }
	
	///	The interval's upper boundary availability.
	public var upperBoundaryAvailability: IntervalBoundaryAvailability { .init(accessibility: upperBoundaryAccessibility) }
	
	///	The interval's lower endpoint.
	public let lowerEndpoint: Endpoint
	
	///	The interval's upper endpoint.
	public let upperEndpoint: Endpoint
	
	//	MARK: - Creating an Interval
	
	///	Creates an interval with the given boundaries and endpoints.
	///	- Parameters:
	///	  - lowerBoundaryAccessibility: The interval's lower boundary accessibility.
	///	  - lowerEndpoint: The interval's lower endpoint.
	///	  - upperEndpoint: The interval's upper endpoint.
	///	  - upperBoundaryAccessibility: The interval's upper boundary accessibility.
	///	  - isInverse: Whether the interval is iterated in the inverse (descending) direction, if `Member` conforms to `Strideable`, default `false`.
	@inlinable
	public init(
		lowerBoundary lowerBoundaryAccessibility: IntervalBoundaryAccessibility,
		lowerEndpoint: Endpoint,
		upperEndpoint: Endpoint,
		upperBoundary upperBoundaryAccessibility: IntervalBoundaryAccessibility,
		inInverseStridingDirection isInverse: Bool = false
	) {
		
		self.lowerBoundaryAccessibility = lowerBoundaryAccessibility
		self.lowerEndpoint = lowerEndpoint
		self.upperEndpoint = upperEndpoint
		self.upperBoundaryAccessibility = upperBoundaryAccessibility
		
		self.isLowerClosed = lowerBoundaryAccessibility == .closed
		self.isUpperClosed = upperBoundaryAccessibility == .closed
		
		//	Compare against `.unbounded` instead of `bounded`, in order to avoid getting the associated values using a switch-case.
		
		self.isLowerBounded = lowerEndpoint != .unbounded
		self.isUpperBounded = upperEndpoint != .unbounded
		
		//	An interval must be proper if it's not bounded.
		
		//	FIXME: Immutable value 'self.isEmpty' may only be initialized once.
		//	FIXME: Immutable value 'self.isDegenerate' may only be initialized once.
		
//		if case let .bounded(lowerEndpoint) = lowerEndpoint,
//		   case let .bounded(upperEndpoint) = upperEndpoint {
//
//			self.isEmpty = lowerEndpoint > upperEndpoint || (
//				isOpen && (lowerEndpoint == upperEndpoint || lowerEndpoint.borders(on: upperEndpoint))
//			)
//
//			self.isDegenerate = !isEmpty && (
//				(isClosed && lowerEndpoint == upperEndpoint) || (isHalfOpen && lowerEndpoint.borders(on: upperEndpoint)) || (isOpen && lowerEndpoint.sharesCommonNeighbor(with: upperEndpoint))
//			)
//
//		}
		
		self.isInverse = isInverse
		
	}
	
	///	Creates an interval with the given boundaries and endpoints.
	///	- Parameters:
	///	  - lowerEndpoint: The interval's lower endpoint.
	///	  - lowerBoundaryAvailability: Whether the interval's lower boundary includes or excludes its corresponding endpoint.
	///	  - upperEndpoint: The interval's upper endpoint.
	///	  - upperBoundaryAvailability: Whether the interval's upper boundary includes or excludes its corresponding endpoint.
	///	  - isInverse: Whether the interval is iterated in the inverse (descending) direction, if `Member` conforms to `Strideable`, default `false`.
	@inlinable
	public init(
		from lowerEndpoint: Member, _ lowerBoundaryAvailability: IntervalBoundaryAvailability,
		to upperEndpoint: Member, _ upperBoundaryAvailability: IntervalBoundaryAvailability,
		inInverseStridingDirection isInverse: Bool = false
	) {
		self.init(
			lowerBoundary: IntervalBoundaryAccessibility(availability: lowerBoundaryAvailability),
			lowerEndpoint: .bounded(lowerEndpoint),
			upperEndpoint: .bounded(upperEndpoint),
			upperBoundary: IntervalBoundaryAccessibility(availability: upperBoundaryAvailability),
			inInverseStridingDirection: isInverse
		)
	}
	
	///	Creates an interval with the given endpoints and overall boundary availability.
	///	- Parameters:
	///	  - lowerEndpoint: The interval's lower endpoint.
	///	  - upperEndpoint: The interval's upper endpoint.
	///	  - boundariesAvailability: Whether the interval's boundaries include or exclude both endpoints.
	///	  - isInverse: Whether the interval is iterated in the inverse (descending) direction, if `Member` conforms to `Strideable`, default `false`.
	@inlinable
	public init(
		from lowerEndpoint: Member, to upperEndpoint: Member, _ boundariesAvailability: IntervalBoundaryAvailability,
		inInverseStridingDirection isInverse: Bool = false
	) {
		self.init(
			from: lowerEndpoint, boundariesAvailability,
			to: upperEndpoint, boundariesAvailability,
			inInverseStridingDirection: isInverse
		)
	}
	
	///	Creates an upper-unbounded interval with the given lower boundary availability and endpoint.
	///	- Parameters:
	///	  - lowerEndpoint: The interval's lower endpoint.
	///	  - lowerBoundaryAvailability: Whether the interval's lower boundary includes or excludes its corresponding endpoint.
	///	  - isInverse: Whether the interval is iterated in the inverse (descending) direction, if `Member` conforms to `Strideable`, default `false`.
	@inlinable
	public init(
		toUnboundedFrom lowerEndpoint: Member, _ lowerBoundaryAvailability: IntervalBoundaryAvailability,
		inInverseStridingDirection isInverse: Bool = false
	) {
		self.init(
			lowerBoundary: IntervalBoundaryAccessibility(availability: lowerBoundaryAvailability),
			lowerEndpoint: .bounded(lowerEndpoint),
			upperEndpoint: .unbounded,
			upperBoundary: .open,
			inInverseStridingDirection: isInverse
		)
	}
	
	///	Creates a lower-unbounded interval with the given upper boundary availability and endpoint.
	///	- Parameters:
	///	  - upperEndpoint: The interval's upper endpoint.
	///	  - upperBoundaryAvailability: Whether the interval's upper boundary includes or excludes its corresponding endpoint.
	///	  - isInverse: Whether the interval is iterated in the inverse (descending) direction, if `Member` conforms to `Strideable`, default `false`.
	@inlinable
	public init(
		fromUnboundedTo upperEndpoint: Member, _ upperBoundaryAvailability: IntervalBoundaryAvailability,
		inInverseStridingDirection isInverse: Bool = false
	) {
		self.init(
			lowerBoundary: .open,
			lowerEndpoint: .unbounded,
			upperEndpoint: .bounded(upperEndpoint),
			upperBoundary: IntervalBoundaryAccessibility(availability: upperBoundaryAvailability),
			inInverseStridingDirection: isInverse
		)
	}
	
	//	MARK: - Creating an Interval from a Range
	
	///	Creates an interval from the given closed range.
	///	- Parameter closedRange: The closed range.
	@inlinable
	public init(closedRange: ClosedRange<Member>) {
		self.init(from: closedRange.lowerBound, to: closedRange.upperBound, .inclusive)
	}
	
	///	Creates an interval from the given lower-closed bounded range.
	///	- Parameter range: The lower-closed bounded range.
	@inlinable
	public init(range: Range<Member>) {
		self.init(from: range.lowerBound, .inclusive, to: range.upperBound, .exclusive)
	}
	
	///	Creates an interval from the given lower-bounded partial range.
	///	- Parameter lowerBoundedPartialRange: The lower-bounded partial range.
	@inlinable
	public init(lowerBoundedPartialRange: PartialRangeFrom<Member>) {
		self.init(toUnboundedFrom: lowerBoundedPartialRange.lowerBound, .inclusive)
	}
	
	///	Creates an interval from the given upper-bounded and -closed partial range.
	///	- Parameter upperBoundedAndClosedPartialRange: The upper-bounded and -closed partial range.
	@inlinable
	public init(upperBoundedAndClosedPartialRange: PartialRangeThrough<Member>) {
		self.init(fromUnboundedTo: upperBoundedAndClosedPartialRange.upperBound, .inclusive)
	}
	
	///	Creates an interval from the given upper-bounded and -open partial range.
	///	- Parameter upperBoundedAndOpenPartialRange: The upper-bounded and -open partial range.
	@inlinable
	public init(upperBoundedAndOpenPartialRange: PartialRangeUpTo<Member>) {
		self.init(fromUnboundedTo: upperBoundedAndOpenPartialRange.upperBound, .exclusive)
	}
	
	///	Creates an interval from the given unbounded range.
	///	- Parameter unboundedRange: The unbounded range.
	@inlinable
	public init(unboundedRange: UnboundedRange) {
		self = Self.unbounded
	}
	
	//	MARK: - Special Intervals
	
	///	An unbounded interval.
	public static var unbounded: Self {
		.init(
			lowerBoundary: .open,
			lowerEndpoint: .unbounded,
			upperEndpoint: .unbounded,
			upperBoundary: .open
		)
	}
	
	//	MARK: - Inspecting Boundaries
	
	///	A Boolean value indicating whether the interval is closed.
	public var isClosed: Bool { isLowerClosed && isUpperClosed }
	
	///	A Boolean value indicating whether the interval is open.
	public var isOpen: Bool { isLowerOpen && isUpperOpen }
	
	///	A Boolean value indicating whether the interval is half-open.
	public var isHalfOpen: Bool { !(isClosed || isOpen) }
	
	///	A Boolean value indicating whether the interval's lower boundary is closed.
	public let isLowerClosed: Bool
	
	///	A Boolean value indicating whether the interval's upper boundary is closed.
	public let isUpperClosed: Bool
	
	///	A Boolean value indicating whether the interval's lower boundary is open.
	public var isLowerOpen: Bool { !isLowerClosed }
	
	///	A Boolean value indicating whether the interval's upper boundary is open.
	public var isUpperOpen: Bool { !isUpperClosed }
	
	//	MARK: - Inspecting Endpoints
	
	///	A Boolean value indicating whether the interval is bounded.
	public var isBounded: Bool { isLowerBounded && isUpperBounded }
	
	///	A Boolean value indicating whether the interval is unbounded.
	public var isUnbounded: Bool { isLowerUnbounded && isUpperUnbounded }
	
	///	A Boolean value indicating whether the interval is half-bounded.
	public var isHalfBounded: Bool { !(isBounded || isUnbounded) }
	
	///	A Boolean value indicating whether the interval's lower endpoint is bounded.
	public let isLowerBounded: Bool
	
	///	A Boolean value indicating whether the interval's upper endpoint is bounded.
	public let isUpperBounded: Bool
	
	///	A Boolean value indicating whether the interval's lower endpoint is unbounded.
	public var isLowerUnbounded: Bool { !isLowerBounded }
	
	///	A Boolean value indicating whether the interval's upper endpoint is unbounded.
	public var isUpperUnbounded: Bool { !isUpperBounded }
	
	//	MARK: - Interval Cardinality
	
	//	FIXME: Use a stored property for `isEmpty`.
	
	///	A Boolean value indicating whether the interval contains no members.
	public var isEmpty: Bool {
		guard
			case let .bounded(lowerBoundedEndpointValue) = lowerEndpoint,
			case let .bounded(upperBoundedEndpointValue) = upperEndpoint
		else { return false }
		return lowerBoundedEndpointValue > upperBoundedEndpointValue
			|| (!isClosed && lowerBoundedEndpointValue == upperBoundedEndpointValue)
			|| (isOpen && lowerBoundedEndpointValue.borders(on: upperBoundedEndpointValue))
	}
	
	//	FIXME: Use a stored property for `isDegenerate`.
	
	///	A Boolean value indicating whether the interval contains 1 and only 1 member.
	public var isDegenerate: Bool {
		guard
			case let .bounded(lowerBoundedEndpointValue) = lowerEndpoint,
			case let .bounded(upperBoundedEndpointValue) = upperEndpoint
		else { return false }
		return !isEmpty && (
			(isClosed && lowerBoundedEndpointValue == upperBoundedEndpointValue) || (isHalfOpen && lowerBoundedEndpointValue.borders(on: upperBoundedEndpointValue)) || (isOpen && lowerBoundedEndpointValue.sharesCommonNeighbor(with: upperBoundedEndpointValue))
		)
	}
	
	///	A Boolean value indicating whether the interval contains more than 1 member.
	public var isProper: Bool { !isEmpty && !isDegenerate }
	
	//	MARK: - Related Intervals
	
	//	The discription for `interior` and `closure` are lifted straightly from Wikipedia: https://en.wikipedia.org/wiki/Interval_(mathematics)#Terminology
	
	///	The interval's interior.
	///
	///	The interior of an interval _I_ is the largest open interval that is contained in _I_; it is also the set of points in _I_ which are not endpoints of _I_.
	///
	///	An empty interval's interior is an empty interior.
	@inlinable
	public var interior: Self {
//		guard self.isProper else { return nil }
		//	An empty interval's interior is an empty interval.
		return Self(
			lowerBoundary: .open,
			lowerEndpoint: self.lowerEndpoint,
			upperEndpoint: self.upperEndpoint,
			upperBoundary: .open,
			inInverseStridingDirection: isInverse
		)
	}
	
	//	TODO: Decide if an unbounded interval can be an closed interval.
	
	///	The interval's closure.
	///
	///	The closure of an interval _I_ is the smallest closed interval that contains _I_; it is also the set _I_ augmented with its finite endpoints.
	@inlinable
	public var closure: Self {
//		guard self.isBounded else { return nil }
		return Self(
			lowerBoundary: .closed,
			lowerEndpoint: self.lowerEndpoint,
			upperEndpoint: self.upperEndpoint,
			upperBoundary: .closed,
			inInverseStridingDirection: isInverse
		)
	}
	
	//	MARK: - Iterating Direction
	
	//	This part is not spun off into an extension `where Member: Strideable`, because extensions can not have stored instance properties, and `isInverse` has to be an instance property.
	
	///	A Boolean value indicating whether the interval is iterated in the inverse (descending) direction.
	///
	///	It's only effective if `Member` conforms to `Strideable`.
	public var isInverse: Bool = false
	
	///	Reverses the interval's iterating direction.
	///
	///	It's only effective if `Member` conforms to `Strideable`.
	@inlinable
	public mutating func reverse() {
		isInverse.toggle()
	}
	
	///	Creates a copy of the interval with its iterating direction reversed.
	///
	///	It's only effective if `Member` conforms to `Strideable`.
	///
	///	- Returns: A copy of the interval with its iterating direction reversed.
	@inlinable
	func reversed() -> Self {
		var newInterval = self
		newInterval.reverse()
		return newInterval
	}
	
	//	MARK: - Comparing Intervals
	
	///	Returns a Boolean value that indicates whether this interval is a subinterval of the given other interval.
	///	- Parameter other: The other interval.
	///	- Returns: `true` if the interval is a subinterval of `other`; otherwise, `false`.
	public func isSubinterval(of other: Self) -> Bool {
		self.assumingBothLowerUnboundedIsContained(within: other) && self.assumingBothUpperUnboundedIsContained(within: other)
	}
	
	///	Returns a Boolean value that indicates whether this interval is a strict subinterval of the given other interval.
	///	- Parameter other: The other interval.
	///	- Returns: `true` if the interval is a strict subinterval of `other`; otherwise, `false`.
	public func isStrictSubinterval(of other: Self) -> Bool {
		(self.isSubinterval(of: other) && self != other)
	}
	
	///	Returns a Boolean value that indicates whether this interval is a superinterval of the given other interval.
	///	- Parameter other: The other interval.
	///	- Returns: `true` if the interval is a superinterval of `other`; otherwise, `false`.
	@inlinable
	public func isSuperinterval(of other: Self) -> Bool {
		other.isSubinterval(of: self)
	}
	
	///	Returns a Boolean value that indicates whether this interval is a strict superinterval of the given other interval.
	///	- Parameter other: The other interval.
	///	- Returns: `true` if the interval is a strict superinterval of `other`; otherwise, `false`.
	@inlinable
	public func isStrictSuperinterval(of other: Self) -> Bool {
		other.isStrictSubinterval(of: self)
	}
	
	///	Returns a Boolean value that indicates whether this interval overlaps the given other interval.
	///	- Parameter other: The other interval.
	///	- Returns: `true` if the interval overlaps `other`; otherwise, `false`.
	@inlinable
	public func overlaps(_ other: Self) -> Bool {
		!(self.fullyPrecedes(other) || self.fullySucceeds(other))
	}
	
	///	Returns a Boolean value that indicates whether this interval fully precedes the given other interval.
	///	- Parameter other: The other interval.
	///	- Returns: `true` if the interval fully precedes `other`; otherwise, `false`.
	@inlinable
	public func fullyPrecedes(_ other: Self) -> Bool {
		guard
			case let .bounded(selfUpperEndpoint) = self.upperEndpoint,
			case let .bounded(otherLowerEndpoint) = other.lowerEndpoint
		else { return false }
		
		if self.isUpperClosed && other.isLowerClosed {
			return selfUpperEndpoint < otherLowerEndpoint
		} else {
			return selfUpperEndpoint <= otherLowerEndpoint
		}
	}
	
	///	Returns a Boolean value that indicates whether this interval fully succeeds the given other interval.
	///	- Parameter other: The other interval.
	///	- Returns: `true` if the interval fully succeeds `other`; otherwise, `false`.
	@inlinable
	public func fullySucceeds(_ other: Self) -> Bool {
		guard
			case let .bounded(otherUpperEndpoint) = other.upperEndpoint,
			case let .bounded(selfLowerEndpoint) = self.lowerEndpoint
		else { return false }
		
		if other.isUpperClosed && self.isLowerClosed {
			return otherUpperEndpoint < selfLowerEndpoint
		} else {
			return otherUpperEndpoint <= selfLowerEndpoint
		}
	}
	
	///	Returns a Boolean value that indicates whether this interval's lower endpoint is no lesser than the given other interval's.
	///	- Parameter other: The other interval.
	///	- Returns: `true` if the interval's lower endpoint is greater than or equal to the other's; otherwise, `false`.
	private func assumingBothUpperUnboundedIsContained(within other: Self) -> Bool {
		guard
			case let .bounded(selfLowerEndpoint) = self.lowerEndpoint,
			case let .bounded(otherLowerEndpoint) = other.lowerEndpoint
		else { return other.isLowerUnbounded }
		
		return selfLowerEndpoint >= otherLowerEndpoint
	}
	
	///	Returns a Boolean value that indicates whether this interval's upper endpoint is no greater than the given other interval's.
	///	- Parameter other: The other interval.
	///	- Returns: `true` if the interval's upper endpoint is less than or equal to the other's; otherwise, `false`.
	private func assumingBothLowerUnboundedIsContained(within other: Self) -> Bool {
		guard
			case let .bounded(selfUpperEndpoint) = self.upperEndpoint,
			case let .bounded(otherUpperEndpoint) = other.upperEndpoint
		else { return other.isUpperUnbounded }
		
		return selfUpperEndpoint <= otherUpperEndpoint
	}
	
	//	MARK: - Testing for Membership
	
	///	Returns a Boolean value indicating whether the given value is contained within the interval.
	///	- Parameter value: The value to check for containment.
	///	- Returns: `true` if `value` is contained within the interval; otherwise, `false`.
	@inlinable
	public func contains(_ value: Member) -> Bool {
		if self.isUnbounded { return true }
		
		var valueIsAboveLowerEndpoint: Bool
		var valueIsBelowUpperEndpoint: Bool
		
		if case let .bounded(lowerEndpoint) = lowerEndpoint {
			valueIsAboveLowerEndpoint = value > lowerEndpoint || (self.isLowerClosed && value == lowerEndpoint)
		} else { valueIsAboveLowerEndpoint = true }
		
		if case let .bounded(upperEndpoint) = upperEndpoint {
			valueIsBelowUpperEndpoint = value < upperEndpoint || (self.isUpperClosed && value == upperEndpoint)
		} else { valueIsBelowUpperEndpoint = true }
		
		return valueIsAboveLowerEndpoint && valueIsBelowUpperEndpoint
	}
	
	///	Returns a Boolean value indicating whether a value is included in an interval.
	///
	///	You can use the pattern-matching operator (`~=`) to test whether a value is included in an interval. The pattern-matching operator is used internally in `case` statements for pattern matching. The following example uses the `~=` operator to test whether an integer is included in an interval of single-digit numbers:
	///
	///	```swift
	///	let chosenNumber = 3
	///	if 0<∙≤10 ~= chosenNumber {
	///	    print("\(chosenNumber) is a single digit.")
	///	}
	///	//	Prints "3 is a single digit."
	///	```
	///
	///	- Parameters:
	///	  - pattern: An interval
	///	  - bound: A value to match against `pattern`.
	///	- Returns: `true` if `value` is contained within `pattern`; otherwise, `false`.
	@inlinable
	public static func ~= (pattern: Self, value: Member) -> Bool {
		return pattern.contains(value)
	}
	
	//	MARK: - Converting Intervals
	
	///	Returns the interval of indices described by another interval within the given collection.
	///
	///	You can use the `relative(to:)` method to convert an interval, which could be half- or fully unbounded, into a bounded interval. The _new_ bounded lower endpoint will have a closed boundary, and upper endpoint open. The following example uses this method to convert `(-∞, 4)` into `[0, 4)`, using an array instance to bound the interval with a lower endpoint.
	///
	///	```swift
	///	let numbers = [10, 20, 30, 40, 50, 60, 70]
	///	let upToFour = ∙∙<4
	///
	///	let i1 = upToFour.relative(to: numbers)
	///	//	i1 == 0≤∙<4
	///	```
	///
	///	The `i1` interval is bounded on the lower end by `0` because that is the starting index of the `numbers` array. When the collection passed to
	///	`relative(to:)` starts with a different index, that index is used as the lower endpoint instead. The next example creates a slice of `numbers` starting at index `2`, and then uses the slice with `relative(to:)` to convert `upToFour` to a bounded interval.
	///
	///	```swift
	///	let numbersSuffix = numbers[2≤∙∙]
	///	//	numbersSuffix == [30, 40, 50, 60, 70]
	///
	///	let i2 = upToFour.relative(to: numbersSuffix)
	///	//	i2 == 2≤∙<4
	///	```
	///
	///	Use this method only if you need the bounded interval it produces. To access a slice of a collection using an interval, use the collection's generic subscript that uses an interval as its parameter.
	///
	///	```swift
	///	let numbersPrefix = numbers[upToFour]
	///	//	numbersPrefix == [10, 20, 30, 40]
	///	```
	///	- Parameter collection: The collection to evaluate this interval in relation to.
	///	- Returns: An interval suitable for slicing `collection`. The returned interval is _not_ guaranteed to be inside the bounds of `collection`. Callers should apply the same preconditions to the return value as they would to an interval provided directly by the user.
	@inlinable
	public func relative<C: Collection>(to collection: C) -> Interval<Member> where C.Index == Member {
		
		if self.isBounded { return self }
		
		var newLowerBoundaryAccessibility: IntervalBoundaryAccessibility
		var newUpperBoundaryAccessibility: IntervalBoundaryAccessibility
		
		var newLowerEndpoint: Endpoint
		var newUpperEndpoint: Endpoint
		
		if self.isLowerUnbounded {
			newLowerEndpoint = .bounded(collection.startIndex)
			newLowerBoundaryAccessibility = .closed
		} else {
			newLowerEndpoint = self.lowerEndpoint
			newLowerBoundaryAccessibility = self.lowerBoundaryAccessibility
		}
		
		if self.isUpperUnbounded {
			newUpperEndpoint = .bounded(collection.endIndex)
			newUpperBoundaryAccessibility = .open
		} else {
			newUpperEndpoint = self.upperEndpoint
			newUpperBoundaryAccessibility = self.upperBoundaryAccessibility
		}
		
		return Interval(
			lowerBoundary: newLowerBoundaryAccessibility,
			lowerEndpoint: newLowerEndpoint,
			upperEndpoint: newUpperEndpoint,
			upperBoundary: newUpperBoundaryAccessibility
		)
		
	}
	
}

//	MARK: - Equatable Conformance

extension Interval: Equatable {
	public static func == (lhs: Self, rhs: Self) -> Bool {
		//	Iterating direction is not considered in equality comparison.
		(lhs.lowerBoundaryAccessibility, lhs.lowerEndpoint, lhs.upperEndpoint, lhs.upperBoundaryAccessibility) == (rhs.lowerBoundaryAccessibility, rhs.lowerEndpoint, rhs.upperEndpoint, rhs.upperBoundaryAccessibility) || (lhs.isEmpty && rhs.isEmpty)
	}
}

//	MARK: - Hashable Conformance

extension Interval: Hashable where Member: Hashable {}

extension Interval.Endpoint: Hashable where Member: Hashable {}

//	MARK: - CustomStringConvertible Conformance

extension Interval: CustomStringConvertible where Member: CustomStringConvertible {
	
	public var description: String {
		
		let lowerBoundaryCharacter: Character = self.isLowerClosed ? "[" : "("
		let upperBoundaryCharacter: Character = self.isUpperClosed ? "]" : ")"
		
		let lowerEndpointString: String
		let upperEndpointString: String
		
		switch lowerEndpoint {
		case .unbounded:
			lowerEndpointString = "-∞"
		case .bounded(let lowerEndpoint):
			lowerEndpointString = String(describing: lowerEndpoint)
		}
		
		switch upperEndpoint {
		case .unbounded:
			upperEndpointString = "∞"
		case .bounded(let upperEndpoint):
			upperEndpointString = String(describing: upperEndpoint)
		}
		
		return "\(lowerBoundaryCharacter)\(lowerEndpointString), \(upperEndpointString)\(upperBoundaryCharacter)"
		
	}
	
}

//	MARK: - LosslessStringConvertible Conformance

extension Interval: LosslessStringConvertible where Member: LosslessStringConvertible {
	
	@inlinable
	public init?(_ description: String) {
		
		guard
			let lowerBoundaryCharacter = description.first,
			let upperBoundaryCharacter = description.last
		else { return nil }
		
		let descriptionSansBoundaryCharacters = description
			.prefix(upTo: description.endIndex)
			.suffix(from: description.index(after: description.startIndex))
			.drop { $0.isWhitespace }
		
		let endpointStrings = descriptionSansBoundaryCharacters.split(separator: ",")
		
		guard endpointStrings.count == 2 else { return nil }
		
		let lowerEndpointString = endpointStrings[0]
		let upperEndpointString = endpointStrings[1]
		
		var lowerBoundaryAccessibility: IntervalBoundaryAccessibility
		var upperBoundaryAccessibility: IntervalBoundaryAccessibility
		
		var lowerEndpoint: Endpoint
		var upperEndpoint: Endpoint
		
		switch lowerBoundaryCharacter {
		case "[": lowerBoundaryAccessibility = .closed
		case "(": lowerBoundaryAccessibility = .open
		default: return nil
		}
		
		switch upperBoundaryCharacter {
		case "]": upperBoundaryAccessibility = .closed
		case ")": upperBoundaryAccessibility = .open
		default: return nil
		}
		
		switch lowerEndpointString {
		case "-∞":
			lowerEndpoint = .unbounded
		default:
			guard let lowerEndpointValue = Member(String(lowerEndpointString)) else { return nil }
			lowerEndpoint = .bounded(lowerEndpointValue)
		}
		
		switch upperEndpointString {
		case "+∞", "∞":
			upperEndpoint = .unbounded
		default:
			guard let upperEndpointValue = Member(String(upperEndpointString)) else { return nil }
			upperEndpoint = .bounded(upperEndpointValue)
		}
		
		self.init(
			lowerBoundary: lowerBoundaryAccessibility,
			lowerEndpoint: lowerEndpoint,
			upperEndpoint: upperEndpoint,
			upperBoundary: upperBoundaryAccessibility
		)
		
	}
	
}

//	MARK: - Interval-Forming Operators

extension IntervalMember {
	
	///	Creates a closed and bounded interval from the given endpoints.
	///	- Parameters:
	///	  - lowerEndpoint: The given lower endpoint.
	///	  - upperEndpoint: The given upper endpoint.
	///	- Returns: A closed and bounded interval.
	@_transparent
	public static func ≤∙≤ (lowerEndpoint: Self, upperEndpoint: Self) -> Interval<Self> {
		return Interval(from: lowerEndpoint, to: upperEndpoint, .inclusive)
	}
	
	///	Creates a lower-closed, upper-open, and bounded interval from the given endpoints.
	///	- Parameters:
	///	  - lowerEndpoint: The given lower endpoint.
	///	  - upperEndpoint: The given upper endpoint.
	///	- Returns: A lower-closed, upper-open, and bounded interval.
	@_transparent
	public static func ≤∙< (lowerEndpoint: Self, upperEndpoint: Self) -> Interval<Self> {
		return Interval(from: lowerEndpoint, .inclusive, to: upperEndpoint, .exclusive)
	}
	
	///	Creates a lower-open, upper-closed, and bounded interval from the given endpoints.
	///	- Parameters:
	///	  - lowerEndpoint: The given lower endpoint.
	///	  - upperEndpoint: The given upper endpoint.
	///	- Returns: A lower-open, upper-closed, and bounded interval.
	@_transparent
	public static func <∙≤ (lowerEndpoint: Self, upperEndpoint: Self) -> Interval<Self> {
		return Interval(from: lowerEndpoint, .exclusive, to: upperEndpoint, .inclusive)
	}
	
	///	Creates an open and bounded interval from the given endpoints.
	///	- Parameters:
	///	  - lowerEndpoint: The given lower endpoint.
	///	  - upperEndpoint: The given upper endpoint.
	///	- Returns: An open and bounded interval.
	@_transparent
	public static func <∙< (lowerEndpoint: Self, upperEndpoint: Self) -> Interval<Self> {
		return Interval(from: lowerEndpoint, to: upperEndpoint, .exclusive)
	}
	
	///	Creates a lower-open and -unbounded and upper-closed and -bounded interval from the given upper endpoint.
	///	- Parameter upperEndpoint: The given upper endpoint.
	///	- Returns: A lower-open and -unbounded and right-closed and -bounded interval.
	@_transparent
	public static prefix func ∙∙≤ (upperEndpoint: Self) -> Interval<Self> {
		return Interval(fromUnboundedTo: upperEndpoint, .inclusive)
	}
	
	///	Creates a lower-unbounded, upper-bounded, and open interval from the given upper endpoint.
	///	- Parameter upperEndpoint: The given upper endpoint.
	///	- Returns: A lower-unbounded, upper-bounded, and open interval.
	@_transparent
	public static prefix func ∙∙< (upperEndpoint: Self) -> Interval<Self> {
		return Interval(fromUnboundedTo: upperEndpoint, .exclusive)
	}
	
	///	Creates a lower-closed and -bounded and upper-open and -unbounded interval from the given lower endpoint.
	///	- Parameter lowerEndpoint: The given lower endpoint.
	///	- Returns: A lower-closed and -bounded and upper-open and -unbounded interval.
	@_transparent
	public static postfix func ≤∙∙ (lowerEndpoint: Self) -> Interval<Self> {
		return Interval(toUnboundedFrom: lowerEndpoint, .inclusive)
	}
	
	///	Creates a lower-bounded, upper-unbounded, and open interval from the given lower endpoint.
	///	- Parameter lowerEndpoint: The given lower endpoint.
	///	- Returns: A lower-bounded, upper-unbounded, and open interval.
	@_transparent
	public static postfix func <∙∙ (lowerEndpoint: Self) -> Interval<Self> {
		return Interval(toUnboundedFrom: lowerEndpoint, .exclusive)
	}
	
}

//	MARK: Inverse Interval-Forming Operators

extension IntervalMember where Self: Strideable {
	
	///	Creates a closed and bounded interval from the given endpoints that's iterated in reverse.
	///	- Parameters:
	///	  - upperEndpoint: The given upper endpoint.
	///	  - lowerEndpoint: The given lower endpoint.
	///	- Returns: A closed and bounded interval that's iterated in reverse.
	@_transparent
	public static func ≥∙≥ (upperEndpoint: Self, lowerEndpoint: Self) -> Interval<Self> {
		return Interval(from: lowerEndpoint, to: upperEndpoint, .inclusive, inInverseStridingDirection: true)
	}
	
	///	Creates a lower-closed, upper-open, and bounded interval from the given endpoints that's iterated in reverse.
	///	- Parameters:
	///	  - upperEndpoint: The given upper endpoint.
	///	  - lowerEndpoint: The given lower endpoint.
	///	- Returns: A lower-closed, upper-open, and bounded interval that's iterated in reverse.
	@_transparent
	public static func >∙≥ (upperEndpoint: Self, lowerEndpoint: Self) -> Interval<Self> {
		return Interval(from: lowerEndpoint, .inclusive, to: upperEndpoint, .exclusive, inInverseStridingDirection: true)
	}
	
	///	Creates a lower-open, upper-closed, and bounded interval from the given endpoints that's iterated in reverse.
	///	- Parameters:
	///	  - upperEndpoint: The given upper endpoint.
	///	  - lowerEndpoint: The given lower endpoint.
	///	- Returns: A lower-open, upper-closed, and bounded interval that's iterated in reverse.
	@_transparent
	public static func ≥∙> (upperEndpoint: Self, lowerEndpoint: Self) -> Interval<Self> {
		return Interval(from: lowerEndpoint, .exclusive, to: upperEndpoint, .inclusive, inInverseStridingDirection: true)
	}
	
	///	Creates an open and bounded interval from the given endpoints that's iterated in reverse.
	///	- Parameters:
	///	  - upperEndpoint: The given upper endpoint.
	///	  - lowerEndpoint: The given lower endpoint.
	///	- Returns: An open and bounded interval that's iterated in reverse.
	@_transparent
	public static func >∙> (upperEndpoint: Self, lowerEndpoint: Self) -> Interval<Self> {
		return Interval(from: lowerEndpoint, to: upperEndpoint, .exclusive, inInverseStridingDirection: true)
	}
	
	///	Creates a lower-open and -unbounded and upper-closed and -bounded interval from the given upper endpoint that's iterated in reverse.
	///	- Parameter upperEndpoint: The given upper endpoint.
	///	- Returns: A lower-open and -unbounded and right-closed and -bounded interval that's iterated in reverse.
	@_transparent
	public static postfix func ≥∙∙ (upperEndpoint: Self) -> Interval<Self> {
		return Interval(fromUnboundedTo: upperEndpoint, .inclusive, inInverseStridingDirection: true)
	}
	
	///	Creates a lower-unbounded, upper-bounded, and open interval from the given upper endpoint that's iterated in reverse.
	///	- Parameter upperEndpoint: The given upper endpoint.
	///	- Returns: A lower-unbounded, upper-bounded, and open interval that's iterated in reverse.
	@_transparent
	public static postfix func >∙∙ (upperEndpoint: Self) -> Interval<Self> {
		return Interval(fromUnboundedTo: upperEndpoint, .exclusive, inInverseStridingDirection: true)
	}
	
	///	Creates a lower-closed and -bounded and upper-open and -unbounded interval from the given lower endpoint that's iterated in reverse.
	///	- Parameter lowerEndpoint: The given lower endpoint.
	///	- Returns: A lower-closed and -bounded and upper-open and -unbounded interval that's iterated in reverse.
	@_transparent
	public static prefix func ∙∙≥ (lowerEndpoint: Self) -> Interval<Self> {
		return Interval(toUnboundedFrom: lowerEndpoint, .inclusive, inInverseStridingDirection: true)
	}
	
	///	Creates a lower-bounded, upper-unbounded, and open interval from the given lower endpoint that's iterated in reverse.
	///	- Parameter lowerEndpoint: The given lower endpoint.
	///	- Returns: A lower-bounded, upper-unbounded, and open interval that's iterated in reverse.
	@_transparent
	public static prefix func ∙∙> (lowerEndpoint: Self) -> Interval<Self> {
		return Interval(toUnboundedFrom: lowerEndpoint, .exclusive, inInverseStridingDirection: true)
	}
	
}
