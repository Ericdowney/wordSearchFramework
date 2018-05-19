//
//  WordSearcherTests.swift
//  wordSearchFramework
//
//  Created by Eric Downey on 5/18/18.
//

import XCTest
@testable import wordSearchFramework

final class WordSearcherTests: XCTestCase {
    
    var subject: WordSearcher!
    
    override func setUp() {
        super.setUp()
        
        subject = WordSearcher()
    }
    
    // MARK: - Tests
    
    func test_shouldReturnAResult() {
        do {
            let result = try subject.findWords(in: "")
            
            XCTAssertNotNil(result)
        }
        catch {
            XCTFail("The Word Search should not throw an error")
        }
    }
    
    // MARK: - Test Registration
    
    static var allTests = [
        ("test_shouldReturnAResult", test_shouldReturnAResult)
    ]
}
