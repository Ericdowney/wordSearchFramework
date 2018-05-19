//
//  WordSearchGrid.swift
//  wordSearchFrameworkTests
//
//  Created by Eric Downey on 5/19/18.
//

import Foundation

struct WordSearchGrid {
    
    enum GridError: Error {
        case minLengthViolation, squareViolation
    }
    
    // MARK: - Properties
    
    var wordsToSearch: [String]
    var grid: [[String]]
    
    // MARK: - Initializer
    
    init(words: [String], grid: String) throws {
        let minCount = words.reduce(1000) { result, next in min(result, next.count) }
        guard minCount >= 2 else {
            throw GridError.minLengthViolation
        }
        self.wordsToSearch = words
        self.grid = grid.components(separatedBy: .newlines).map { $0.components(separatedBy: ",") }
    }
}
