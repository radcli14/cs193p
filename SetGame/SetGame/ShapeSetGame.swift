//
//  ShapeSetGame.swift
//  SetGame
//
//  Created by Eliott Radcliffe on 1/20/24.
//

import Foundation

class ShapeSetGame: ObservableObject {
    @Published private var model = createSetGame()
    
    private static func createSetGame() -> SetGame {
        return SetGame()
    }
    
    typealias Card = SetGame.Card
    
    var cards: [Card] {
        return model.cards
    }
    
    var visibleCards: [Card] {
        return Array(model.cards[0..<model.numberOfVisibleCards])
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
}
