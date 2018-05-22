//
//  XCTAssertWord.swift
//  wordSearchFrameworkTests
//
//  Created by Eric Downey on 5/20/18.
//

import XCTest
@testable import wordSearchFramework

func XCTAssertWord(_ word: String, at positions: WordSearcherResult.Position..., in result: WordSearchGridTraverser.TraversalResult, file: StaticString = #file, line: UInt = #line) {
    
    XCTAssertEqual(positions.count, word.count, "The number of positions do not match the result", file: file, line: line)
    XCTAssertEqual(result.positions.count, positions.count, "The number of positions do not match the result", file: file, line: line)
    guard positions.count == word.count else {
        return
    }
    
    guard result.positions.count == positions.count else {
        return
    }
    
    XCTAssertEqual(result.word, word)
    for (i, pos) in result.positions.enumerated() {
        XCTAssertEqual(pos.x, positions[i].x, file: file, line: line)
        XCTAssertEqual(pos.y, positions[i].y, file: file, line: line)
    }
}
