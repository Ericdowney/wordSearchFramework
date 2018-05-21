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

    // MARK: - Tests
    
    func test_shouldThrowAnErrorWhenAGivenWordHasALengthLessThan2() {
        let words = ["Hello", "There", "Goodbye", "1"]
        
        do {
            _ = try WordSearchGrid(words: words, grid: "")
            XCTFail()
        }
        catch {
            XCTAssertEqual(WordSearchGrid.GridError.minLengthViolation, error as? WordSearchGrid.GridError)
        }
        
    }
    
    func test_shouldInitializeProperlyWhenAllWordsHaveALengthGreaterOrEqualTo2() {
        let words = ["Hello", "There", "Goodbye", "12"]
        let gridStr = "A,B,C,D,E,F\nG,H,I,J,K,L\nM,N,O,P,Q,R\nA,B,C,D,E,F\nG,H,I,J,K,L\nM,N,O,P,Q,R"
        
        do {
            subject = try WordSearchGrid(words: words, grid: gridStr)
            
            XCTAssertEqual(subject.wordsToSearch, words)
        }
        catch {
            XCTFail("The Word Grid should not throw an error")
        }
    }
    
    func test_shouldThrowAnErrorWhenTheGivenGridIsNotSquare() {
        let words = ["Hello", "There", "Goodbye", "12"]
        let gridStr = "A,B,C,D,E,F\nG,H,I,J,K,L\nM,N,O,P,Q,R\nA,B,C,D,E,F"
        
        do {
            _ = try WordSearchGrid(words: words, grid: gridStr)
            XCTFail()
        }
        catch {
            XCTAssertEqual(WordSearchGrid.GridError.squareViolation, error as? WordSearchGrid.GridError)
        }
    }
    
    func test_shouldThrowAnErrorWhenTheGivenGridIsNotSquareWithUnevenRows() {
        let words = ["Hello", "There", "Goodbye", "12"]
        let gridStr = "A,B,C,D,E,F\nG,H,I,J\nM\nA,B,C,D,E,F\nA,B,C,D,E,F\nM,N"
        
        do {
            _ = try WordSearchGrid(words: words, grid: gridStr)
            XCTFail()
        }
        catch {
            XCTAssertEqual(WordSearchGrid.GridError.squareViolation, error as? WordSearchGrid.GridError)
        }
    }
    
    func test_shouldParseTheWordGridStringSuccessfully() {
        let words = ["Hello", "There", "Goodbye", "12"]
        let gridStr = "A,B,C,D,E,F\nG,H,I,J,K,L\nM,N,O,P,Q,R\nA,B,C,D,E,F\nG,H,I,J,K,L\nM,N,O,P,Q,R"
        
        do {
            subject = try WordSearchGrid(words: words, grid: gridStr)
            
            XCTAssertEqual(subject.characterGrid, [["A", "B", "C", "D", "E", "F"], ["G", "H", "I", "J", "K", "L"], ["M", "N", "O", "P", "Q", "R"], ["A", "B", "C", "D", "E", "F"], ["G", "H", "I", "J", "K", "L"], ["M", "N", "O", "P", "Q", "R"]])
        }
        catch {
            XCTFail("The Word Grid should not throw an error")
        }
    }
    
    func test_shouldNotFindWordInDownDirection() {
        let words = ["BONES"]
        let gridStr = "A,B,A,A,A\nA,A,O,A,A\nA,N,A,A,A\nE,A,A,A,A\nA,A,A,S,A"
        
        do {
            subject = try WordSearchGrid(words: words, grid: gridStr)
            
            let result = subject.traverse()
            XCTAssertEqual(result[0].positions.count, 0)
            XCTAssertEqual(result[0].word, "BONES")
        }
        catch {
            XCTFail("The Word Grid should not throw an error")
        }
    }
    
    func test_shouldFindWordInDownDirection() {
        let words = ["BONES"]
        let gridStr = "A,B,A,A,A\nA,O,A,A,A\nA,N,A,A,A\nA,E,A,A,A\nA,S,A,A,A"
        
        do {
            subject = try WordSearchGrid(words: words, grid: gridStr)
            
            let result = subject.traverse()
            XCTAssertWord("BONES", at: (1,0), (1,1), (1,2), (1,3), (1,4), in: result[0])
        }
        catch {
            XCTFail("The Word Grid should not throw an error")
        }
    }
    
    func test_shouldFindWordInDownDirectionDiagonally() {
        let words = ["BONES"]
        let gridStr = "B,A,A,A,A\nA,O,A,A,A\nA,A,N,A,A\nA,A,A,E,A\nA,A,A,A,S"
        
        do {
            subject = try WordSearchGrid(words: words, grid: gridStr)
            
            let result = subject.traverse()
            XCTAssertWord("BONES", at: (0,0), (1,1), (2,2), (3,3), (4,4), in: result[0])
        }
        catch {
            XCTFail("The Word Grid should not throw an error")
        }
    }
    
    func test_shouldFindWordInRightDirection() {
        let words = ["BONES"]
        let gridStr = "B,O,N,E,S\nA,A,A,A,A\nA,A,A,A,A\nA,A,A,A,A\nA,A,A,A,A"
        
        do {
            subject = try WordSearchGrid(words: words, grid: gridStr)
            
            let result = subject.traverse()
            XCTAssertWord("BONES", at: (0,0), (1,0), (2,0), (3,0), (4,0), in: result[0])
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
        ("test_shouldFindWordInDownDirection", test_shouldFindWordInDownDirection),
        ("test_shouldFindWordInDownDirection", test_shouldFindWordInDownDirection),
        ("test_shouldFindWordInDownDirectionDiagonally", test_shouldFindWordInDownDirectionDiagonally),
        ("test_shouldFindWordInRightDirection", test_shouldFindWordInRightDirection),
    ]
    
}

func XCTAssertWord(_ word: String, at positions: WordSearcherResult.Position..., in result: WordSearchGrid.TraversalResult, file: StaticString = #file, line: UInt = #line) {
    
    XCTAssertEqual(positions.count, word.count, "The number of positions do not match the result", file: file, line: line)
    XCTAssertEqual(result.positions.count, positions.count, "The number of positions do not match the result", file: file, line: line)
    
    XCTAssertEqual(result.word, word)
    for (i, pos) in result.positions.enumerated() {
        XCTAssertEqual(pos.x, positions[i].x)
        XCTAssertEqual(pos.y, positions[i].y)
    }
}
