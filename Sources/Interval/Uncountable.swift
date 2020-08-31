//
//	Uncountable.swift - Uncountable types, and protocol implementations for them.
//
//	Created by Wowbagger & His Liquid Lunch on 20-08-21.
//

///	This file extends `Comparable` with the 2 methods required in `IntervalMember`.

//
//	Uncountable types are the norm, and countable the exception.

extension Comparable {
	///	Inspects if the value is right next to the given other value.
	///	- Requires: If `Self` conforms to `Countable`, then both `self.borders(on: self.immediatePredecessor)` and `self.borders(on: self.immediateSuccessor)` must evaluate to `true`.
	///	- Parameter other: The given other value.
	///	- Returns: `true` if the 2 values are right next to each other, `false` otherwise.
	@inlinable
	public func borders(on other: Self) -> Bool {
		return false
	}
	
	///	Inspects if the value shares a common neighbor with the given other value.
	///	- Parameter other: The given other value.
	///	- Returns: `true` if the 2 values are both right next to a 3rd value, `false` otherwise.
	///	- Note: The 2 values could be equal, if the function returns true.
	@inlinable
	public func sharesCommonNeighbor(with other: Self) -> Bool {
		self == other
	}
}

//extension Strideable {
//	///	Inspects the correctness of the Bacon number (or, degrees of separation) between this value and the given other value.
//	///	- Precondition: `degrees >= 0`.
//	///	- Parameters:
//	///	  - other: The given other value.
//	///	  - degrees: The Bacon number.
//	///	- Returns: `true` if the Bacon number is correct, `false` otherwise.
//	@inlinable
//	public func separates(from other: Self, byDegrees degrees: Stride) -> Bool {
//		degrees == 0 && self == other
//	}
//}
