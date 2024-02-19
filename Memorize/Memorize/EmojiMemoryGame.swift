//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Eliott Radcliffe on 1/11/24.
//

import Foundation
import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static func createMemoryGame() -> MemoryGame<String> {
        return createMemoryGame(with: Constants.defaultTheme)
    }
    
    private static func createMemoryGame(with theme: EmojiTheme) -> MemoryGame<String> {
        let themeEmojis = theme.emojis.shuffled()
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
    
    @Published private var model = createMemoryGame()
    
    typealias Card = MemoryGame<String>.Card

    var cards: Array<Card> {
        return model.cards
    }
    
    var score: Int {
        return model.score
    }
    
    // MARK: - Theming
    
    @Published private var theme: EmojiTheme = HalloweenTheme()
    
    let themes: [EmojiTheme] = [HalloweenTheme(), HandsTheme(), SportsTheme(), FlagTheme(), TechTheme(), AnimalTheme()]
    
    var themeName: String {
        theme.name
    }
    
    var themeColor: Color {
        switch theme.cardColor.lowercased() {
        case "red": return .red
        case "orange": return .orange
        case "yellow": return .yellow
        case "green": return .green
        case "blue": return .blue
        case "indigo": return .indigo
        case "purple": return .purple
        default: return .gray
        }
    }
    
    func isSelected(_ themeToCheck: EmojiTheme) -> Bool {
        return theme.name == themeToCheck.name
    }
    
    // MARK: - Intents
    
    func startNewGame() {
        var newTheme = themes.randomElement()
        while newTheme?.name == theme.name {
            newTheme = themes.randomElement()
        }
        changeTheme(to: newTheme ?? Constants.defaultTheme)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func changeTheme(to theme: EmojiTheme) {
        self.theme = theme
        model = EmojiMemoryGame.createMemoryGame(with: theme)
    }
    
    // MARK: - Constants
    
    private struct Constants {
        static let defaultTheme = HalloweenTheme()
    }
}
