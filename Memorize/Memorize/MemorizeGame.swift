//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Eliott Radcliffe on 1/11/24.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    func chooseCard(card: Card) {
        
    }
    
    struct Card {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
}
