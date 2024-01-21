//
//  SetGame.swift
//  SetGame
//
//  Created by Eliott Radcliffe on 1/20/24.
//

import Foundation

struct SetGame {
    let cards = createCards()
    
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
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        let number: NumberOfShapes
        let typeOfShape: TypeOfShape
        let shading: Shading
        let color: ShapeColor
        
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
