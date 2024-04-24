//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Eliott Radcliffe on 1/11/24.
//

import Foundation
import SwiftUI

class EmojiMemoryGame: ObservableObject {

    let theme: EmojiTheme
    @Published private var model: MemoryGame<String>

    // MARK: - Initialization
    
    init(theme: EmojiTheme) {
        self.theme = theme
        model = EmojiMemoryGame.createMemoryGame(with: theme)
    }
    
    private static func createMemoryGame(with theme: EmojiTheme) -> MemoryGame<String> {
        let themeEmojis = theme.emojis.map(String.init).shuffled()
        var game = MemoryGame(numberOfPairsOfCards: theme.nPairs) { pairIndex in
            if themeEmojis.indices.contains(pairIndex) {
                return themeEmojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
        game.shuffle()
        return game
    }
    
    // MARK: - Game Info

    typealias Card = MemoryGame<String>.Card

    var cards: Array<Card> {
        return model.cards
    }
    
    var score: Int {
        return model.score
    }
    
    var color: Color {
        Color(rgba: theme.cardColor)
    }
    
    // MARK: - Intents
    
    func newGame() {
        model = EmojiMemoryGame.createMemoryGame(with: theme)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
}
