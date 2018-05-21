//
//  WordSearchGridTraverserTests.swift
//  wordSearchFrameworkTests
//
//  Created by Eric Downey on 5/20/18.
//

import XCTest
@testable import wordSearchFramework

final class WordSearchGridTraverserTests: XCTestCase {
    
    var testWords = ["BONES","KHAN","KIRK","SCOTTY","SPOCK","SULU","UHURA"]
    var testGridData = """
        U,M,K,H,U,L,K,I,N,V,J,O,C,W,E
        L,L,S,H,K,Z,Z,W,Z,C,G,J,U,Y,G
        H,S,U,P,J,P,R,J,D,H,S,B,X,T,G
        B,R,J,S,O,E,Q,E,T,I,K,K,G,L,E
        A,Y,O,A,G,C,I,R,D,Q,H,R,T,C,D
        S,C,O,T,T,Y,K,Z,R,E,P,P,X,P,F
        B,L,Q,S,L,N,E,E,E,V,U,L,F,M,Z
        O,K,R,I,K,A,M,M,R,M,F,B,A,P,P
        N,U,I,I,Y,H,Q,M,E,M,Q,R,Y,F,S
        E,Y,Z,Y,G,K,Q,J,P,C,Q,W,Y,A,K
        S,J,F,Z,M,Q,I,B,D,B,E,M,K,W,D
        T,G,L,B,H,C,B,E,C,H,T,O,Y,I,K
        O,J,Y,E,U,L,N,C,C,L,Y,B,Z,U,H
        W,Z,M,I,S,U,K,U,R,B,I,D,U,X,S
        K,Y,L,B,Q,Q,P,M,D,F,C,K,E,A,B
    """
    var subject: WordSearchGridTraverser!
    
    override func setUp() {
        super.setUp()
        
        subject = try? WordSearchGridTraverser(words: testWords, gridContent: testGridData)
    }
    
    // MARK: - Integration Tests
    
    func test_shouldFindAllWordsInGrid() {
        let results = subject.findWords()
        
        XCTAssertWord("BONES", at: (0,6),(0,7),(0,8),(0,9),(0,10), in: results[0])
        XCTAssertWord("KHAN", at: (5,9),(5,8),(5,7),(5,6), in: results[1])
        XCTAssertWord("KIRK", at: (4,7),(3,7),(2,7),(1,7), in: results[2])
        XCTAssertWord("SCOTTY", at: (0,5),(1,5),(2,5),(3,5),(4,5),(5,5), in: results[3])
        XCTAssertWord("SPOCK", at: (2,1),(3,2),(4,3),(5,4),(6,5), in: results[4])
        XCTAssertWord("SULU", at: (3,3),(2,2),(1,1),(0,0), in: results[5])
        XCTAssertWord("UHURA", at: (4,0),(3,1),(2,2),(1,3),(0,4), in: results[6])
    }
    
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
        ("test_shouldFindAllWordsInGrid", test_shouldFindAllWordsInGrid),
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
