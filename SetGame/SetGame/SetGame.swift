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
    
    // MARK: Dealing
    
    private let initialNumberOfVisibleCards = 12
    var visibleCards: [Card] = []
    var matchedCards: [Card] {
        cards.filter { card in card.isMatched }
    }
    var deck: [Card] {
        cards.filter { card in !(visibleCards.contains(card) || matchedCards.contains(card)) }
    }
    
    mutating func newGame() {
        cards.shuffle()
        unChooseAllCards()
        visibleCards = []
    }
    
    mutating func deal() {
        visibleCards = Array(cards[0..<initialNumberOfVisibleCards])
    }
    
    mutating func deal3() {
        if !deck.isEmpty {
            for _ in 0 ..< 3 {
                if let newCard = deck.first {
                    visibleCards.append(newCard)
                }
            }
        }
    }
    
    // MARK: Choose Cards
    
    var chosenCards: [Card] {
        cards.filter { $0.isChosen }
    }
    var chosenIndices: [Int] {
        chosenCards.map { card in cards.firstIndex(of: card)! }
    }

    mutating func choose(_ card: Card) {
        print("User chose card \(card)")
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            // This is the first new card selected after three were already selected, delect everything that has been tapped to this point
            if chosenCards.count == 3 {
                print("  Three cards were already selected")
                flipCardsThatAreMatched()
                unChooseAllCards()
            }
            
            // This is a card that was tapped before a count of three was reached, choose or unchoose it
            if cards[chosenIndex].isFaceUp, chosenCards.count <= 3, !cards[chosenIndex].isMatched {
                cards[chosenIndex].isChosen.toggle()
                print("  Toggled isChosen to \(cards[chosenIndex].isChosen)")
            }
            
            print("  chosenCards.count = \(chosenCards.count)")
            
            // If it is a set, then these are matched
            if chosenCards.isSet {
                print("    Found a complete set!")
                chosenIndices.forEach { index in
                    cards[index].isMatched = true
                    print("      Toggled \(cards[index]).isMatched to \(cards[index].isMatched )")
                }
            }
            
            if chosenCards.countIsValid && !chosenCards.isSet {
                print("    The selected cards are not a correct set")
                print("      countIsValid = \(chosenCards.countIsValid)")
                print("      numberCanMakeValidSet = \(chosenCards.numberCanMakeValidSet)")
                print("      typeOfShapeCanMakeValidSet = \(chosenCards.typeOfShapeCanMakeValidSet)")
                print("      shadingCanMakeValidSet = \(chosenCards.shadingCanMakeValidSet)")
                print("      colorCanMakeValidSet = \(chosenCards.colorCanMakeValidSet)")
            }
        }
    }
    
    private mutating func unChooseAllCards() {
        cards.indices.forEach { index in
            if cards[index].isChosen {
                cards[index].isChosen = false
                print("      Toggled \(cards[index]).isChosen to \(cards[index].isChosen )")
            }
        }
    }
    
    private mutating func flipCardsThatAreMatched() {
        chosenIndices.forEach { index in
            if cards[index].isMatched {
                cards[index].isFaceUp = false
                print("      Toggled \(cards[index]).isFaceUp to \(cards[index].isFaceUp )")
            }
        }
    }
    
    // MARK: Card
    
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
