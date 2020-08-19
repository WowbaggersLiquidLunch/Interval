//
//	Interval Boundary Conditions.swift - A boundary's condition.
//
//	Created by Wowbagger & His Liquid Lunch on 20-08-16.
//

///	This file comtains the definitaion of `IntervalBoundaryAccessibility` and `IntervalBoundaryAvailability` structs. The structs are defined ouside of the `Interval` generic struct, because boundary conditions are a universal feature across all intervals, and so an interval's boundary conditions shouldn't be bound by the interval's member's type.

//

///	A boundary condition, either closed or open.
public enum IntervalBoundaryAccessibility: String {
	///	Adapts the boundary condition from the "inclusive"/"exclusive" spelling to the "closed"/"open" spelling.
	///	- Parameter boundaryAvailability: The given "inclusive"/"exclusive" spelling.
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

///	A boundary condition, either inclusive or exclusive.
public enum IntervalBoundaryAvailability: String {
	///	Adapts the boundary condition from the "closed"/"open" spelling to the "inclusive"/"exclusive" spelling.
	///	- Parameter boundaryAccessibility: The given "closed"/"open" spelling.
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
