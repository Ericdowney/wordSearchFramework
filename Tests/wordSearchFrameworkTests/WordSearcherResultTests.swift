//
//  WordSearcherResultTests.swift
//  wordSearchFrameworkTests
//
//  Created by Eric Downey on 5/18/18.
//

import XCTest
@testable import wordSearchFramework

final class WordSearcherResultTests: XCTestCase {
    
    var subject: WordSearcherResult!
    
    override func setUp() {
        super.setUp()
        
        subject = WordSearcherResult()
    }
    
    // MARK: - Tests
    
    func test_shouldAddAWordWithOccurances() {
        subject.add(word: "Hello", occuringAt: [(1, 2), (4, 5)])
        
        XCTAssertEqual(subject.words.first?.0, "Hello")
        XCTAssertEqual(subject.words.first?.1.first?.x, 1)
        XCTAssertEqual(subject.words.first?.1.first?.y, 2)
        XCTAssertEqual(subject.words.last?.1.last?.x, 4)
        XCTAssertEqual(subject.words.last?.1.last?.y, 5)
    }
    
    func test_shouldOutputWordsWithOccurancesInAString() {
        subject.add(word: "Hello", occuringAt: [(1, 2), (4, 5)])
        subject.add(word: "Goodbye", occuringAt: [(2, 3), (1, 5)])
        
        let result = "\(subject!)"
        
        XCTAssertEqual(result, "Hello: (1,2),(4,5)\nGoodbye: (2,3),(1,5)")
    }
    
    // MARK: - Test Registration
    
    static var allTests = [
        ("test_shouldAddAWordWithOccurances", test_shouldAddAWordWithOccurances),
        ("test_shouldOutputWordsWithOccurancesInAString", test_shouldOutputWordsWithOccurancesInAString),
    ]
}

// MARK: - Custom Matcher

/// Assert equality of an optional expression (left side) and a non-optional expression (right side)
func XCTAssertEqual<T: Equatable>(_ expression1: T?, expression2: T, _ message: String = "First expression is nil", file: StaticString = #file, line: UInt32 = #line) {
    guard let exp1 = expression1 else {
        XCTFail(message)
        return
    }
    XCTAssertEqual(exp1, expression2)
}
