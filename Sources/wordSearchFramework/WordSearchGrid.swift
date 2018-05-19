//
//  WordSearchGrid.swift
//  wordSearchFrameworkTests
//
//  Created by Eric Downey on 5/19/18.
//

import Foundation

struct WordSearchGrid {
    
    enum GridError: Error {
        case minLengthViolation
    }
    
    // MARK: - Properties
    
    var wordsToSearch: [String]
    
    // MARK: - Initializer
    
    init(words: [String]) throws {
        let minCount = words.reduce(1000) { result, next in min(result, next.count) }
        guard minCount >= 2 else {
            throw GridError.minLengthViolation
        }
        self.wordsToSearch = words
    }
}
