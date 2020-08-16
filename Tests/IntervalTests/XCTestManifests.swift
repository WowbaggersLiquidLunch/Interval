import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(IntervalInitialisationTests.allTests),
		testCase(IntervalBoundaryInitialisationTests.allTests),
		testCase(IntervalBoundaryIndependenceTests.allTests)
    ]
}
#endif
