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
        for col in 0..<grid.characterGrid.count {
            for row in 0..<grid.characterGrid.count {
                if let result = searchForWord(word, col: col, row: row) {
                    return result
                }
            }
        }
        
        return []
    }
    
    private func searchForWord(_ word: String, col: Int, row: Int) -> [WordSearcherResult.Position]? {
        guard let char = word[0]?.string else {
            return nil
        }
        guard char == grid.characterGrid[col][row].character else {
            return nil
        }
        
        var result: [WordSearcherResult.Position] = [(row, col)]
        
        let xDir = [-1, -1, -1, 0, 0, 1, 1, 1]
        let yDir = [-1, 0, 1, -1, 1, -1, 0, 1]
        
        for dir in 0..<8 {
            
            var xd = col + xDir[dir]
            var yd = row + yDir[dir]
            
            for i in 1..<word.count {
                guard xd >= 0 && xd < grid.characterGrid.count,
                    yd >= 0 && yd < grid.characterGrid.count else {
                    break
                }
                guard grid.characterGrid[xd][yd].character == word[i]?.string else {
                    break
                }
                result.append( (yd, xd) )
                xd += xDir[dir]
                yd += yDir[dir]
            }
            
            if result.count == word.count {
                break
            }
        }
        
        guard result.count == word.count else {
            return nil
        }
        
        return result
    }
}

private extension Character {
    var string: String {
        return "\(self)"
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
