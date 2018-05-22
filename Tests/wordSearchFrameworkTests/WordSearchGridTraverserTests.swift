//
//  WordSearchGridTraverserTests.swift
//  wordSearchFrameworkTests
//
//  Created by Eric Downey on 5/20/18.
//

import XCTest
@testable import wordSearchFramework

final class WordSearchGridTraverserTests: XCTestCase {
    
    var subject: WordSearchGridTraverser!
    
    // MARK: - Unit Tests
    
    func test_shouldNotFindWords() {
        let words = ["BONES"]
        let gridStr = "A,B,A,A,A\nA,A,O,A,A\nA,N,A,A,A\nE,A,A,A,A\nA,A,A,S,A"
        
        do {
            subject = try WordSearchGridTraverser(words: words, gridContent: gridStr)
            
            let result = subject.findWords()
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
            subject = try WordSearchGridTraverser(words: words, gridContent: gridStr)
            
            let result = subject.findWords()
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
            subject = try WordSearchGridTraverser(words: words, gridContent: gridStr)
            
            let result = subject.findWords()
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
            subject = try WordSearchGridTraverser(words: words, gridContent: gridStr)
            
            let result = subject.findWords()
            XCTAssertWord("BONES", at: (0,0), (1,0), (2,0), (3,0), (4,0), in: result[0])
        }
        catch {
            XCTFail("The Word Grid should not throw an error")
        }
    }
    
    func test_shouldFindWordInRightDirectionInThirdRow() {
        let words = ["BONES"]
        let gridStr = "A,A,A,A,A\nA,A,A,A,A\nB,O,N,E,S\nA,A,A,A,A\nA,A,A,A,A"
        
        do {
            subject = try WordSearchGridTraverser(words: words, gridContent: gridStr)
            
            let result = subject.findWords()
            XCTAssertWord("BONES", at: (0,2), (1,2), (2,2), (3,2), (4,2), in: result[0])
        }
        catch {
            XCTFail("The Word Grid should not throw an error")
        }
    }
    
    func test_shouldFindWordInDownDirectionDiagonallyBackwards() {
        let words = ["BONES"]
        let gridStr = "A,A,A,A,B\nA,A,A,O,A\nA,A,N,A,A\nA,E,A,A,A\nS,A,A,A,A"
        
        do {
            subject = try WordSearchGridTraverser(words: words, gridContent: gridStr)
            
            let result = subject.findWords()
            XCTAssertWord("BONES", at: (4,0), (3,1), (2,2), (1,3), (0,4), in: result[0])
        }
        catch {
            XCTFail("The Word Grid should not throw an error")
        }
    }
    
    func test_shouldFindWordInLeftDirection() {
        let words = ["BONES"]
        let gridStr = "S,E,N,O,B\nA,A,A,A,A\nA,A,A,A,A\nA,A,A,A,A\nA,A,A,A,A"
        
        do {
            subject = try WordSearchGridTraverser(words: words, gridContent: gridStr)
            
            let result = subject.findWords()
            XCTAssertWord("BONES", at: (4,0), (3,0), (2,0), (1,0), (0,0), in: result[0])
        }
        catch {
            XCTFail("The Word Grid should not throw an error")
        }
    }
    
    func test_shouldFindWordInUpsideDownDownDirection() {
        let words = ["BONES"]
        let gridStr = "A,S,A,A,A\nA,E,A,A,A\nA,N,A,A,A\nA,O,A,A,A\nA,B,A,A,A"
        
        do {
            subject = try WordSearchGridTraverser(words: words, gridContent: gridStr)
            
            let result = subject.findWords()
            XCTAssertWord("BONES", at: (1,4), (1,3), (1,2), (1,1), (1,0), in: result[0])
        }
        catch {
            XCTFail("The Word Grid should not throw an error")
        }
    }
    
    // MARK: - Test Registration
    
    static var allTests = [
        ("test_shouldNotFindWords", test_shouldNotFindWords),
        ("test_shouldFindWordInDownDirection", test_shouldFindWordInDownDirection),
        ("test_shouldFindWordInDownDirectionDiagonally", test_shouldFindWordInDownDirectionDiagonally),
        ("test_shouldFindWordInRightDirection", test_shouldFindWordInRightDirection),
        ("test_shouldFindWordInRightDirectionInThirdRow", test_shouldFindWordInRightDirectionInThirdRow),
        ("test_shouldFindWordInDownDirectionDiagonallyBackwards", test_shouldFindWordInDownDirectionDiagonallyBackwards),
        ("test_shouldFindWordInLeftDirection", test_shouldFindWordInLeftDirection),
        ("test_shouldFindWordInUpsideDownDownDirection", test_shouldFindWordInUpsideDownDownDirection),
    ]
}
