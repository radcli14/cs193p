//
//  SetGame.swift
//  SetGame
//
//  Created by Eliott Radcliffe on 1/20/24.
//

import Foundation

struct SetGame {
    private(set) var cards = createCards()
    
    static private func createCards(shuffled: Bool = true) -> [Card] {
        var cards: [Card] = []
        for number in NumberOfShapes.allCases {
            for type in TypeOfShape.allCases {
                for shading in Shading.allCases {
                    for color in ShapeColor.allCases  {
                        cards.append(
                            Card(number, type, shading, color)
                        )
                    }
                }
            }
        }
        return shuffled ? cards.shuffled() : cards
    }
    
    var numberOfVisibleCards = 25
    
    var chosenCards: [Card] {
        cards.filter { $0.isChosen }
    }
    var chosenIndices: [Int] {
        chosenCards.map { card in cards.firstIndex(of: card)! }
    }
    mutating func unChooseAll() {
        cards.indices.forEach { index in
            cards[index].isChosen = false
        }
    }
    
    mutating func flipCardsThatAreMatched() {
        chosenIndices.forEach { index in
            if cards[index].isMatched {
                cards[index].isFaceUp = false
            }
        }
    }

    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            // This is the first new card selected after three were already selected, delect everything that has been tapped to this point
            if chosenCards.countIsValid {
                flipCardsThatAreMatched()
                unChooseAll()
            }
            
            // This is a card that was tapped before a count of three was reached, choose or unchoose it
            if cards[chosenIndex].isFaceUp, chosenCards.count <= 3, !cards[chosenIndex].isMatched {
                cards[chosenIndex].isChosen.toggle()
            }
            
            // If it is a set, then these are matched
            if chosenCards.isSet {
                chosenIndices.forEach { index in
                    cards[index].isMatched = true
                }
            }
        }
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        let number: NumberOfShapes
        let typeOfShape: TypeOfShape
        let shading: Shading
        let color: ShapeColor
        
        var isFaceUp = true
        var isChosen = false
        var isMatched = false
        
        init(_ number: NumberOfShapes, _ typeOfShape: TypeOfShape, _ shading: Shading, _ color: ShapeColor) {
            self.number = number
            self.typeOfShape = typeOfShape
            self.shading = shading
            self.color = color
        }
        
        var n: Int {
            number == .one ? 1 : number == .two ? 2 : 3
        }
        
        var id: String {
            "[\(number)-\(typeOfShape)-\(shading)-\(color)]"
        }
        
        var debugDescription: String {
            return id
        }
    }
}

extension [SetGame.Card] {
    var isSet: Bool {
        return countIsValid && numberCanMakeValidSet && typeOfShapeCanMakeValidSet && shadingCanMakeValidSet && colorCanMakeValidSet
    }
    
    var countIsValid: Bool {
        self.count == 3
    }
    
    var numberCanMakeValidSet: Bool {
        Set(self.map { $0.number }).count != 2
    }
    
    var typeOfShapeCanMakeValidSet: Bool {
        Set(self.map { $0.typeOfShape }).count != 2
    }
    
    var shadingCanMakeValidSet: Bool {
        Set(self.map { $0.shading }).count != 2
    }
    
    var colorCanMakeValidSet: Bool {
        Set(self.map { $0.color }).count != 2
    }
}
