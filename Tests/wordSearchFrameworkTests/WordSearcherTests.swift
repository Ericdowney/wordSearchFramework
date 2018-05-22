//
//  WordSearcherTests.swift
//  wordSearchFramework
//
//  Created by Eric Downey on 5/18/18.
//

import XCTest
@testable import wordSearchFramework

final class WordSearcherTests: XCTestCase {
    
    var testGridData = """
BONES,KHAN,KIRK,SCOTTY,SPOCK,SULU,UHURA
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
    
    // MARK: - Tests
    
    func test_shouldFindAllWordsInGrid() {
        do {
            let result = try WordSearcher.findWords(in: testGridData)
            
            XCTAssertWord("BONES", at: (0,6),(0,7),(0,8),(0,9),(0,10), in: result.words[0])
            XCTAssertWord("KHAN", at: (5,9),(5,8),(5,7),(5,6), in: result.words[1])
            XCTAssertWord("KIRK", at: (4,7),(3,7),(2,7),(1,7), in: result.words[2])
            XCTAssertWord("SCOTTY", at: (0,5),(1,5),(2,5),(3,5),(4,5),(5,5), in: result.words[3])
            XCTAssertWord("SPOCK", at: (2,1),(3,2),(4,3),(5,4),(6,5), in: result.words[4])
            XCTAssertWord("SULU", at: (3,3),(2,2),(1,1),(0,0), in: result.words[5])
            XCTAssertWord("UHURA", at: (4,0),(3,1),(2,2),(1,3),(0,4), in: result.words[6])
        }
        catch {
            XCTFail("The Word Search should not throw an error")
        }
    }
    
    func test_shouldThrowAnEmptyStringError() {
        do {
            let _ = try WordSearcher.findWords(in: "")
            XCTFail()
        }
        catch {
            XCTAssertEqual(WordSearcher.WordError.emptyStringViolation, error as? WordSearcher.WordError)
        }
    }
    
    func test_shouldReturnAResult() {
        do {
            let result = try WordSearcher.findWords(in: "thing")
            
            XCTAssertNotNil(result)
        }
        catch {
            XCTFail("The Word Search should not throw an error")
        }
    }
    
    // MARK: - Test Registration
    
    static var allTests = [
        ("test_shouldFindAllWordsInGrid", test_shouldFindAllWordsInGrid),
        ("test_shouldThrowAnEmptyStringError", test_shouldThrowAnEmptyStringError),
        ("test_shouldReturnAResult", test_shouldReturnAResult),
    ]
}
