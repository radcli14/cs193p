//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Eliott Radcliffe on 1/11/24.
//

import Foundation
import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static let emojis = ["👻", "🎃", "🕷️", "👺", "🏴‍☠️", "🧌", "👽", "💀", "🧞", "🤖"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return createMemoryGame(with: emojis)
    }
    
    private static func createMemoryGame(with emojis: [String]) -> MemoryGame<String> {
        var game = MemoryGame(numberOfPairsOfCards: 8) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
        game.shuffle()
        return game
    }
    
    @Published private var model = createMemoryGame()
    
    let themes: [EmojiTheme] = [HalloweenTheme(), HandsTheme(), SportsTheme()]
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ index: Int) {
        model.choose(index)
    }
    
    func changeTheme(to theme: EmojiTheme) {
        model = EmojiMemoryGame.createMemoryGame(with: theme.emojis)
    }
}
