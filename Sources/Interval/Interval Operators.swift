//
//	Interval Operators.swift
//	
//	Created by Wowbagger & His Liquid Lunch on 20-07-18.
//

//	MARK: Ascending Interval operators.

infix operator ≤∙≤: RangeFormationPrecedence
infix operator ≤∙<: RangeFormationPrecedence
infix operator <∙≤: RangeFormationPrecedence
infix operator <∙<: RangeFormationPrecedence

prefix operator ∙∙≤
prefix operator ∙∙<

postfix operator ≤∙∙
postfix operator <∙∙

//	MARK: Descending interval operators.

infix operator ≥∙≥: RangeFormationPrecedence
infix operator >∙≥: RangeFormationPrecedence
infix operator ≥∙>: RangeFormationPrecedence
infix operator >∙>: RangeFormationPrecedence

postfix operator ≥∙∙
postfix operator >∙∙

prefix operator ∙∙≥
prefix operator ∙∙>
