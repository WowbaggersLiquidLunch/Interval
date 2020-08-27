//
//	Boundary.swift - A boundary of an interval.
//
//	Created by Wowbagger & His Liquid Lunch on 20-08-16.
//

///	This file comtains the definitaion of `IntervalBoundaryAccessibility` and `IntervalBoundaryAvailability` structs. The structs are defined ouside of the `Interval` generic struct, because boundaries are universal across all intervals, and not bound by the interval's member's type.

//

///	A boundary, either closed or open.
public enum IntervalBoundaryAccessibility: String {
	///	Adapts the boundary from the "inclusive"/"exclusive" spelling to the "closed"/"open" spelling.
	///	- Parameter boundaryAvailability: The given "inclusive"/"exclusive" spelling.
	@inlinable
	public init(availability boundaryAvailability: IntervalBoundaryAvailability) {
		switch boundaryAvailability {
		case .exclusive: self = .open
		case .inclusive: self = .closed
		}
	}
	
	///	A closed boundary
	case closed
	///	An open boundary
	case open
}

///	A boundary, either inclusive or exclusive.
public enum IntervalBoundaryAvailability: String {
	///	Adapts the boundary from the "closed"/"open" spelling to the "inclusive"/"exclusive" spelling.
	///	- Parameter boundaryAccessibility: The given "closed"/"open" spelling.
	@inlinable
	public init(accessibility boundaryAccessibility: IntervalBoundaryAccessibility) {
		switch boundaryAccessibility {
		case .open: self = .exclusive
		case .closed: self = .inclusive
		}
	}
	
	///	An inclusive boundary.
	case inclusive
	///	An exclusive boundary.
	case exclusive
}
