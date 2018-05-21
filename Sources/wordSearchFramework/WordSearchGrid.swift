//
//  WordSearchGrid.swift
//  wordSearchFrameworkTests
//
//  Created by Eric Downey on 5/19/18.
//

import Foundation

fileprivate struct WordSearchGrid {
    
    struct Letter {
        var character: String
        var position: WordSearcherResult.Position
    }
    
    // MARK: - Properties
    
    var wordsToSearch: [String]
    var characterGrid: [[Letter]]
    
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
        self.characterGrid = []
        for (y, row) in tmpGrid.enumerated() {
            var newRow: [Letter] = []
            for (x, char) in row.enumerated() {
                newRow.append(Letter(character: char, position: (x, y)))
            }
            self.characterGrid.append(newRow)
        }
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
                findPositions(for: word)
            )
        }
    }
    
    private func findPositions(for word: String) -> [WordSearcherResult.Position] {
        var results: [WordSearcherResult.Position] = []
        
        for (y, row) in grid.characterGrid.enumerated() {
            for (x, _) in row.enumerated() {
                if let result = searchForWord(word, x: x, y: y) {
                    results.append(result)
                }
            }
        }
        
        return results
    }
    
    private func searchForWord(_ word: String, x: Int, y: Int) -> WordSearcherResult.Position? {
        return nil
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
