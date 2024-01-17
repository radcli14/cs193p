//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Eliott Radcliffe on 1/11/24.
//

import Foundation
import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static let defaultTheme = HalloweenTheme()
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return createMemoryGame(with: defaultTheme)
    }
    
    private static func createMemoryGame(with theme: EmojiTheme) -> MemoryGame<String> {
        var game = MemoryGame(numberOfPairsOfCards: theme.nPairs) { pairIndex in
            let themeEmojis = theme.emojis.shuffled()
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

    var cards: Array<MemoryGame<String>.Card> {
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
    
    // MARK: - Intents
    
    func startNewGame() {
        var newTheme = themes.randomElement()
        while newTheme?.name == theme.name {
            newTheme = themes.randomElement()
        }
        changeTheme(to: newTheme ?? EmojiMemoryGame.defaultTheme)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func changeTheme(to theme: EmojiTheme) {
        self.theme = theme
        model = EmojiMemoryGame.createMemoryGame(with: theme)
    }
}
