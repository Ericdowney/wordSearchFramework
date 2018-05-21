//
//  WordSearchGrid.swift
//  wordSearchFrameworkTests
//
//  Created by Eric Downey on 5/19/18.
//

import Foundation

fileprivate struct WordSearchGrid {
    
    // MARK: - Properties
    
    var wordsToSearch: [String]
    var characterGrid: [[String]]
    
    // MARK: - Initializer
    
    init(words: [String], gridContent: String) throws {
        let minCount = words.reduce(1000) { result, next in min(result, next.count) }
        guard minCount >= 2 else {
            throw WordSearchGridTraverser.GridError.minLengthViolation
        }
        self.wordsToSearch = words
        let tmpGrid = gridContent.components(separatedBy: .newlines).map { $0.components(separatedBy: ",") }
        
        let childrenCountMatch = tmpGrid.map { $0.count }.reduce(0, +) == tmpGrid.count * tmpGrid[0].count
        guard childrenCountMatch && tmpGrid[0].count == tmpGrid.count else {
            throw WordSearchGridTraverser.GridError.squareViolation
        }
        self.characterGrid = tmpGrid
    }
}

struct WordSearchGridTraverser {
    typealias TraversalResult = (word: String, positions: [WordSearcherResult.Position])
    
    enum GridError: Error {
        case minLengthViolation, squareViolation
    }
    
    // MARK: - Properties
    
    fileprivate var grid: WordSearchGrid
    
    // MARK: - Initializer
    
    init(words: [String], gridContent: String) throws {
        self.grid = try WordSearchGrid(words: words, gridContent: gridContent)
    }
    
    // MARK: - Methods
    
    func findWords() -> [TraversalResult] {
        return grid.wordsToSearch.compactMap { word in
            (
                word,
                findWords(word: word, withCharacterIndex: 0, andRowIndex: 0, in: grid)
            )
        }
    }
    
    private func findWords(word: String, withCharacterIndex cIndex: Int, andRowIndex rIndex: Int, in grid: WordSearchGrid, previousPosition: WordSearcherResult.Position? = nil, allPositions: [WordSearcherResult.Position] = []) -> [WordSearcherResult.Position] {
        guard let char = word[cIndex] else {
            return allPositions
        }
        guard let x = grid.characterGrid.first?.index(of: "\(char)") else {
            return []
        }
        
        let newPos = (x, rIndex)
        if let previousPosition = previousPosition {
            guard isAdjacent(previousPosition, rhs: newPos) else {
                return []
            }
            return findWords(word: word, withCharacterIndex: cIndex + 1, andRowIndex: rIndex + 1, in: grid, previousPosition: newPos, allPositions: allPositions + [newPos])
        }
        return findWords(word: word, withCharacterIndex: cIndex + 1, andRowIndex: rIndex + 1, in: grid, previousPosition: newPos, allPositions: allPositions + [newPos])
    }
    
    private func isAdjacent(_ lhs: WordSearcherResult.Position, rhs: WordSearcherResult.Position) -> Bool {
        if lhs.x + 1 == rhs.x && lhs.y == rhs.y { return true }
        if lhs.x == rhs.x && lhs.y + 1 == rhs.y { return true }
        if lhs.x + 1 == rhs.x && lhs.y + 1 == rhs.y { return true }
        return false
    }
}

private extension String {
    subscript(i: Int) -> Character? {
        guard let index = index(startIndex, offsetBy: i, limitedBy: index(before: endIndex)) else {
            return nil
        }
        return self[index]
    }
}
