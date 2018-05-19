//
//  WordSearchGridTests.swift
//  wordSearchFrameworkTests
//
//  Created by Eric Downey on 5/19/18.
//

import XCTest
@testable import wordSearchFramework

final class WordSearchGridTests: XCTestCase {
    
    var subject: WordSearchGrid!
    
    override func setUp() {
        super.setUp()
        
        subject = try? WordSearchGrid(words: ["Hello", "There"])
    }

    
    // MARK: - Tests
    
    func test_shouldThrowAnErrorWhenAGivenWordHasALengthLessThan2() {
        let words = ["Hello", "There", "Goodbye", "1"]
        
        do {
            _ = try WordSearchGrid(words: words)
            XCTFail()
        }
        catch {
            XCTAssertEqual(WordSearchGrid.GridError.minLengthViolation, error as? WordSearchGrid.GridError)
        }
        
    }
    
    func test_shouldInitializeProperlyWhenAllWordsHaveALengthGreaterOrEqualTo2() {
        let words = ["Hello", "There", "Goodbye", "12"]
        
        do {
            subject = try WordSearchGrid(words: words)
            
            XCTAssertEqual(subject.wordsToSearch, words)
        }
        catch {
            XCTFail("The Word Grid should not throw an error")
        }
    }
    
    // MARK: - Test Registration
    
    static var allTests = [
        ("test_shouldThrowAnErrorWhenAGivenWordHasALengthLessThan2", test_shouldThrowAnErrorWhenAGivenWordHasALengthLessThan2),
        ("test_shouldInitializeProperlyWhenAllWordsHaveALengthGreaterOrEqualTo2", test_shouldInitializeProperlyWhenAllWordsHaveALengthGreaterOrEqualTo2)
    ]
    
}
