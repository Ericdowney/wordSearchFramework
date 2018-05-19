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
    
    enum GridDirection {
        case natural
    }
    
    // MARK: - Properties
    
    var wordsToSearch: [String]
    var characterGrid: [[String]]
    
    // MARK: - Initializer
    
    init(words: [String], grid: String) throws {
        let minCount = words.reduce(1000) { result, next in min(result, next.count) }
        guard minCount >= 2 else {
            throw GridError.minLengthViolation
        }
        self.wordsToSearch = words
        let tmpGrid = grid.components(separatedBy: .newlines).map { $0.components(separatedBy: ",") }
        
        let childrenCountMatch = tmpGrid.map { $0.count }.reduce(0, +) == tmpGrid.count * tmpGrid[0].count
        guard childrenCountMatch && tmpGrid[0].count == tmpGrid.count else {
            throw GridError.squareViolation
        }
        self.characterGrid = tmpGrid
    }
    
    func traverse(_ direction: GridDirection) -> [(word: String, positions: [WordSearcherResult.Position])] {
        switch direction {
        case .natural:
            return traverse(grid: characterGrid)
        }
    }
    
    private func traverse(grid: [[String]]) -> [(word: String, positions: [WordSearcherResult.Position])] {
        return []
    }
}
