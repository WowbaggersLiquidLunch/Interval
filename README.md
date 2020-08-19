# Interval

This library introduces a generic `Interval` type that intends to unify Swift's `Range` and its likes. The current implementation is spun out of Swift's draft pull request [#32865](https://github.com/apple/swift/pull/32865), with some bug fixes, and a lot more test cases.

`Interval` is continuously updated. At the moment, I'm working on bringing the test coverage to 100%. Things like adding interval arithmatics and set algebra are in the plan. I'm also exploring ways of [incorporating compile-time type chedking into interval iteration](https://forums.swift.org/t/unify-and-expand-range-and-its-likes/38427/4) without separating interval representation into multiple types.
