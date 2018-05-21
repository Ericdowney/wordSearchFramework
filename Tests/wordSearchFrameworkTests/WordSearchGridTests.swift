//
//  WordSearchGridTests.swift
//  wordSearchFrameworkTests
//
//  Created by Eric Downey on 5/19/18.
//

import XCTest
@testable import wordSearchFramework

final class WordSearchGridTests: XCTestCase {
    
    var subject: WordSearchGridTraverser!

    // MARK: - Tests
    
    func test_shouldThrowAnErrorWhenAGivenWordHasALengthLessThan2() {
        let words = ["Hello", "There", "Goodbye", "1"]
        
        do {
            _ = try WordSearchGridTraverser(words: words, gridContent: "")
            XCTFail()
        }
        catch {
            XCTAssertEqual(WordSearchGridTraverser.GridError.minLengthViolation, error as? WordSearchGridTraverser.GridError)
        }
        
    }
    
    func test_shouldInitializeProperlyWhenAllWordsHaveALengthGreaterOrEqualTo2() {
        let words = ["Hello", "There", "Goodbye", "12"]
        let gridStr = "A,B,C,D,E,F\nG,H,I,J,K,L\nM,N,O,P,Q,R\nA,B,C,D,E,F\nG,H,I,J,K,L\nM,N,O,P,Q,R"
        
        do {
            subject = try WordSearchGridTraverser(words: words, gridContent: gridStr)
            
            XCTAssertNotNil(subject, "This is valid because the test is to determine if an error was thrown or not")
        }
        catch {
            XCTFail("The Word Grid should not throw an error")
        }
    }
    
    func test_shouldThrowAnErrorWhenTheGivenGridIsNotSquare() {
        let words = ["Hello", "There", "Goodbye", "12"]
        let gridStr = "A,B,C,D,E,F\nG,H,I,J,K,L\nM,N,O,P,Q,R\nA,B,C,D,E,F"
        
        do {
            _ = try WordSearchGridTraverser(words: words, gridContent: gridStr)
            XCTFail()
        }
        catch {
            XCTAssertEqual(WordSearchGridTraverser.GridError.squareViolation, error as? WordSearchGridTraverser.GridError)
        }
    }
    
    func test_shouldThrowAnErrorWhenTheGivenGridIsNotSquareWithUnevenRows() {
        let words = ["Hello", "There", "Goodbye", "12"]
        let gridStr = "A,B,C,D,E,F\nG,H,I,J\nM\nA,B,C,D,E,F\nA,B,C,D,E,F\nM,N"
        
        do {
            _ = try WordSearchGridTraverser(words: words, gridContent: gridStr)
            XCTFail()
        }
        catch {
            XCTAssertEqual(WordSearchGridTraverser.GridError.squareViolation, error as? WordSearchGridTraverser.GridError)
        }
    }
    
    func test_shouldParseTheWordGridStringSuccessfully() {
        let words = ["Hello", "There", "Goodbye", "12"]
        let gridStr = "A,B,C,D,E,F\nG,H,I,J,K,L\nM,N,O,P,Q,R\nA,B,C,D,E,F\nG,H,I,J,K,L\nM,N,O,P,Q,R"
        
        do {
            subject = try WordSearchGridTraverser(words: words, gridContent: gridStr)

            XCTAssertNotNil(subject, "This is valid because the test is to determine if an error was thrown or not")
        }
        catch {
            XCTFail("The Word Grid should not throw an error")
        }
    }
    
    // MARK: - Test Registration
    
    static var allTests = [
        ("test_shouldThrowAnErrorWhenAGivenWordHasALengthLessThan2", test_shouldThrowAnErrorWhenAGivenWordHasALengthLessThan2),
        ("test_shouldInitializeProperlyWhenAllWordsHaveALengthGreaterOrEqualTo2", test_shouldInitializeProperlyWhenAllWordsHaveALengthGreaterOrEqualTo2),
        ("test_shouldThrowAnErrorWhenTheGivenGridIsNotSquare", test_shouldThrowAnErrorWhenTheGivenGridIsNotSquare),
        ("test_shouldThrowAnErrorWhenTheGivenGridIsNotSquareWithUnevenRows", test_shouldThrowAnErrorWhenTheGivenGridIsNotSquareWithUnevenRows),
        ("test_shouldParseTheWordGridStringSuccessfully", test_shouldParseTheWordGridStringSuccessfully),
    ]
    
}
