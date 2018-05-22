//
//  WordSearcherResult.swift
//  wordSearchFramework
//
//  Created by Eric Downey on 5/18/18.
//

import Foundation

public struct WordSearcherResult {
    typealias Position = (x: Int, y: Int)
    
    var words: [(String, [Position])] = []
    
    mutating func add(word: String, occuringAt positions: [Position]) {
        words.append((word, positions))
    }
}

extension WordSearcherResult: CustomStringConvertible {
    public var description: String {
        return words.map { element in
            "\(element.0): \(transformPositionArray(element.1))"
        }.joined(separator: "\n")
    }
    
    private func transformPositionArray(_ positions: [Position]) -> String {
        return positions.map(transformPosition).joined(separator: ",")
    }
    
    private func transformPosition(pos: Position) -> String {
        return "(\(pos.0),\(pos.1))"
    }
}
