//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Eliott Radcliffe on 1/11/24.
//

import Foundation
import SwiftUI

class EmojiMemoryGame: ObservableObject {

    private var theme: EmojiTheme
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

    @Published var dealt = Set<Card.ID>()
    
    var name: String {
        return theme.name
    }
    
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
    
    func updateTheme(to newTheme: EmojiTheme) {
        theme = newTheme
    }
    
    func newGame() {
        dealt.removeAll()
        model = EmojiMemoryGame.createMemoryGame(with: theme)
    }
    
    func dealCard(with cardId: Card.ID) {
        _ = dealt.insert(cardId)
    }
    
    /// Assure that there is not a partial deal when you navigate away from the game and back
    func makeSureAllCardsAreDealtIfAnyAreDealt() {
        if dealt.count > 0 {
            dealt = Set(cards.map { $0.id })
        }
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
}
