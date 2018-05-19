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
    
    // MARK: - Properties
    
    // MARK: - Methods
    
    public func findWords(in content: String) throws -> WordSearcherResult {
        guard !content.isEmpty else {
            throw WordError.emptyStringViolation
        }
        return WordSearcherResult()
    }
    
}
