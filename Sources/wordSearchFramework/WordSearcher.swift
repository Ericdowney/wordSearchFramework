//
//  WordFileParser.swift
//  wordSearchFramework
//
//  Created by Eric Downey on 5/18/18.
//

import Foundation

public struct WordSearcher {
    
    public enum WordError: Error {
        case emptyStringViolation
    }
    
    // MARK: - Static Methods
    
    public static func findWords(in content: String) throws -> WordSearcherResult {
        guard !content.isEmpty else {
            throw WordError.emptyStringViolation
        }
        let contentLines = content.components(separatedBy: .newlines)
        let words = contentLines[0].components(separatedBy: ",")
        let gridContent = contentLines[1...].joined(separator: "\n")
        let traverser = try WordSearchGridTraverser(words: words, gridContent: gridContent)
        
        var result = WordSearcherResult()
        traverser.findWords().forEach { traversalResult in
            result.add(word: traversalResult.word, occuringAt: traversalResult.positions)
        }
        return result
    }
    
}
