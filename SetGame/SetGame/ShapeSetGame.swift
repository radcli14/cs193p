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
    
    func newGame() {
        model.newGame()
    }
    
    func deal() {
        model.deal()
    }
    
    typealias Card = SetGame.Card
    
    var cards: [Card] {
        return model.cards
    }
    
    var deck: [Card] {
        return model.deck
    }
    
    var visibleCards: [Card] {
        return model.visibleCards
    }
    
    var chosenCards: [Card] {
        return model.chosenCards
    }
    
    var discarded: [Card] {
        return model.discarded
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    var chosenCardsAreASet: Bool? {
        model.chosenCards.countIsValid ? model.chosenCards.isSet : nil
    }

    func deal3() {
        model.deal3()
    }
}
