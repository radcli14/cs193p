//
//  EmojiArt.swift
//  Emoji Art
//
//  Created by Eliott Radcliffe on 4/1/24.
//

import Foundation

struct EmojiArt {
    var background: URL?
    private(set) var emojis = [Emoji]()
    
    private var uniqueEmojiId = 0
    
    mutating func addEmoji(_ emoji: String, at position: Emoji.Position, size: Int) {
        uniqueEmojiId += 1
        emojis.append(Emoji(
            string: emoji,
            position: position, 
            size: size,
            id: uniqueEmojiId
        ))
    }
    
    struct Emoji: Identifiable {
        let string: String
        let position: Position
        let size: Int
        var id: Int
        
        struct Position {
            var x: Int
            var y: Int
            
            static let zero = Self(x: 0, y: 0)
        }
    }
}
