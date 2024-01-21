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
    
    var cards: Array<SetGame.Card> {
        return model.cards
    }
}
