//
//	IntervalMember.swift - Protocol requirements for Interval.Member.
//
//	Created by Wowbagger & His Liquid Lunch on 20-08-21.
//

///	This file defines `IntervalMember`, and conforms `Comparable` types in the standard library and Foundation to it.

//

import Foundation

///	A type that can be accepted by `Interval` as its `Member`.
///
///	In order to find its cardinality, an interval needs to compare the proximity of its lower and upper endpoints. The proximity comes in the form of degrees of separation between the 2 endpoints' values.
///
///	`isEmpty`, `isDegenerate`, and `isProper` are `Interval`'s 3 computed instance properties for inspecting an interval's cardinality. They compare the proximity of the lower and upper endpoints through the instance method `borders(on:)`, which returns `true` if and only if `Member` is `Countable` and the endpoints are right next to each other (1 degree of separation). When the interval is bounded with its endpoints having different values, the degrees of separation between the endpoints is computable only if their type represent only members of a countable set, i.e. if the type is `Countable` such as `Int`.
///
///	The definition of `Interval` dictates that `Interval.Member` must be `Comparable`. An earlier implementation of the `Interval` module extends `Comparable` with `borders(on:)` to achieve proximity comparison between endpoints, and differentiate the method's behaviour for countable types from that for uncountable types through protocol specialisation. This approach turned out to be insufficient, because members defined in protocol extensions receive static dispatch, which always treats `Interval.Member` as an uncountable type. The only way around this restriction is using a protocol requirement, namely `IntervalMember`.
///
///	`IntervalMember` does not provide default Implementation to methods it requires. Instead, they are provided by `Countable` (for countable types) and as an extension to `Comparable` (for uncountable types). This is for several reasons:
///
///	1. `IntervalMember` is itself a workaround around static dispatch of `Comparable`'s methods. Since `Comparable` is still the principle identity of `IntervalMember` types, the implementation should be in a `Comparable` extension.
///
///	2. Conceptually, the methods required by `IntervalMember` should be available to all `Comparable` types, without them explicitly conforming to `IntervalMember` first.
///
///	3. Because `Countable` inherits from `Comparable` (via `Strideable`), not from `IntervalMember`, it's structurally more balanced to have the methods implemented in `Countable` and `Comparable`.
///
///	# Conforming to the IntervalMember Protocol
///
///	Conformance to `IntervalMember` are already added to all `Comparable` types in the standard library and Foundation. New types need only conformance to `Comparable` first, before conforming to `IntervalMember`.
///
///	- SeeAlso: Relevant [discussion](https://forums.swift.org/t/compiler-fails-to-use-the-more-specialised-implementation/39552) on the Swift forums.
///	- SeeAlso: `IntervalMember` for additional design rationales.
public protocol IntervalMember: Comparable {
	///	Inspects if this value is right next to the given other value.
	///	- Requires: If `Self` conforms to `Countable`, then both `self.borders(on: self.immediatePredecessor)` and `self.borders(on: self.immediateSuccessor)` must evaluate to `true`.
	///	- Parameter other: The given other value.
	///	- Returns: `true` if the 2 values are right next to each other, `false` otherwise.
	@inlinable
	func borders(on other: Self) -> Bool
	
	///	Inspects if the value shares a common neighbor with the given other value.
	///	- Parameter other: The given other value.
	///	- Returns: `true` if the 2 values are both right next to a 3rd value, `false` otherwise.
	///	- Note: The 2 values could be equal, if the function returns true.
	@inlinable
	func sharesCommonNeighbor(with other: Self) -> Bool
}

//	MARK: - IntervalMember Conformance for Standard Library Types

//	MARK: BinaryInteger-Conforming Types
extension Int: IntervalMember {}
extension Int64: IntervalMember {}
extension Int32: IntervalMember {}
extension Int16: IntervalMember {}
extension Int8: IntervalMember {}
extension UInt: IntervalMember {}
extension UInt64: IntervalMember {}
extension UInt32: IntervalMember {}
extension UInt16: IntervalMember {}
extension UInt8: IntervalMember {}

//	MARK: BinaryFloatingPoint-Conforming Types
extension Double: IntervalMember {}
extension Float: IntervalMember {}
extension Float80: IntervalMember {}
//	TODO: Make `Float16` available as soon it becomes available.
//	See https://github.com/apple/swift/commit/103961a7d5f8853ac518f4d8151de0f5b64d8ccf#diff-1c8541c68839b7021db7e4ab68135c3e for details.
//extension Float16: IntervalMember {}

//	MARK: Character- and String-Related Types
extension Character: IntervalMember {}
extension String: IntervalMember {}
extension String.Index: IntervalMember {}
extension Substring: IntervalMember {}
extension Unicode.CanonicalCombiningClass: IntervalMember {}
extension Unicode.Scalar: IntervalMember {}

//	MARK: Unsafe Types
extension UnsafeRawPointer: IntervalMember {}
extension UnsafeMutableRawPointer: IntervalMember {}

//	MARK: Collection Types' Nested Types
extension ClosedRange.Index: IntervalMember where Bound: Hashable {}
extension Dictionary.Index: IntervalMember {}
extension FlattenSequence.Index: IntervalMember where Base.Index: Hashable, Base.Element: Hashable, Base.Element.Index: Hashable {}
extension LazyPrefixWhileSequence.Index: IntervalMember where Base.Index: Hashable {}
extension ReversedCollection.Index: IntervalMember where Base.Index: Hashable {}
extension Set.Index: IntervalMember {}

//	MARK: Ungrouped Types
extension AnyIndex: IntervalMember {}
extension ObjectIdentifier: IntervalMember {}

//	MARK: Special Types
extension Never: IntervalMember {}

//	MARK: Conditionally Available Types
@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *) extension CollectionDifference.Index: IntervalMember {}

//	MARK: - IntervalMember Conformance for Foundation Types

extension Date: IntervalMember {}
extension IndexPath: IntervalMember {}
extension Decimal: IntervalMember {}
extension DispatchTime: IntervalMember {}
extension DispatchWallTime: IntervalMember {}


//	MARK: Conditionally Available Types

@available(macOS 10.12, macCatalyst 13, iOS 10, watchOS 3, tvOS 10, *) extension DateInterval: IntervalMember {}
@available(macOS 10.12, macCatalyst 13, iOS 10, watchOS 3, tvOS 10, *) extension Measurement: IntervalMember {}

//	`SchedulerTimeType`s isn't available on Linux.
#if !os(Linux)
@available(macOS 10.15, macCatalyst 13, iOS 13, watchOS 6, tvOS 13, *) extension DispatchQueue.SchedulerTimeType: IntervalMember {}
@available(macOS 10.15, macCatalyst 13, iOS 13, watchOS 6, tvOS 13, *) extension DispatchQueue.SchedulerTimeType.Stride: IntervalMember {}
@available(macOS 10.15, macCatalyst 13, iOS 13, watchOS 6, tvOS 13, *) extension OperationQueue.SchedulerTimeType: IntervalMember {}
@available(macOS 10.15, macCatalyst 13, iOS 13, watchOS 6, tvOS 13, *) extension OperationQueue.SchedulerTimeType.Stride: IntervalMember {}
@available(macOS 10.15, macCatalyst 13, iOS 13, watchOS 6, tvOS 13, *) extension RunLoop.SchedulerTimeType: IntervalMember {}
@available(macOS 10.15, macCatalyst 13, iOS 13, watchOS 6, tvOS 13, *) extension RunLoop.SchedulerTimeType.Stride: IntervalMember {}
#endif
