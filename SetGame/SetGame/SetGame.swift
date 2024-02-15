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
    
    var chosenCards: [Card] {
        cards.filter { $0.isChosen }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            
            cards[chosenIndex].isChosen.toggle()
        }
        
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        let number: NumberOfShapes
        let typeOfShape: TypeOfShape
        let shading: Shading
        let color: ShapeColor
        
        var isFaceUp = true
        var isChosen = false
        
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
