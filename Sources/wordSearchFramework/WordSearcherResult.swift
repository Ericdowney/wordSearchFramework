//
//  WordSearcherResult.swift
//  wordSearchFramework
//
//  Created by Eric Downey on 5/18/18.
//

import Foundation

public struct WordSearcherResult {
    typealias Position = (x: Int, y: Int)
    
    var words: [String: [Position]] = [:]
    
    /// Sets the positions for the occurances of words. Will override previously added words.
    mutating func add(word: String, occuringAt positions: Position...) {
        words[word] = positions
    }
    
}
