//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Eliott Radcliffe on 1/11/24.
//

import Foundation
import SwiftUI

class EmojiMemoryGame: ObservableObject {

    private var theme = Constants.defaultTheme
    
    init(theme: EmojiTheme) {
        self.theme = theme
        model = EmojiMemoryGame.createMemoryGame(with: theme)
    }
    
    init() {}
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return createMemoryGame(with: Constants.defaultTheme)
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
    
    @Published private var model = createMemoryGame(with: Constants.defaultTheme)
    
    typealias Card = MemoryGame<String>.Card

    var cards: Array<Card> {
        return model.cards
    }
    
    var score: Int {
        return model.score
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
    
    // MARK: - Constants
    
    private struct Constants {
        static let defaultTheme = EmojiTheme.halloween
    }
}
