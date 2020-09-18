//
//	Operators.swift - Interval-forming operators.
//	
//	Created by Wowbagger & His Liquid Lunch on 20-07-18.
//

//	MARK: Ascending Interval-Forming Operators

infix operator ≤∙≤: RangeFormationPrecedence
infix operator ≤∙<: RangeFormationPrecedence
infix operator <∙≤: RangeFormationPrecedence
infix operator <∙<: RangeFormationPrecedence

prefix operator ∙∙≤
prefix operator ∙∙<

postfix operator ≤∙∙
postfix operator <∙∙

//	MARK: Descending Interval-Forming Operators

infix operator ≥∙≥: RangeFormationPrecedence
infix operator >∙≥: RangeFormationPrecedence
infix operator ≥∙>: RangeFormationPrecedence
infix operator >∙>: RangeFormationPrecedence

postfix operator ≥∙∙
postfix operator >∙∙

prefix operator ∙∙≥
prefix operator ∙∙>

//	MARK: Interval-Combining Operators

infix operator ∩: AdditionPrecedence
