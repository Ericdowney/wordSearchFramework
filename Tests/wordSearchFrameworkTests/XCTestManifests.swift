import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(WordSearcher.allTests),
        testCase(WordSearcherResult.allTests),
        testCase(WordSearchGridTests.allTests),
    ]
}
#endif
