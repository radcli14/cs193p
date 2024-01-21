//
//  SetGame.swift
//  SetGame
//
//  Created by Eliott Radcliffe on 1/20/24.
//

import Foundation

enum CardCondition: CaseIterable {
    case one
    case two
    case three
}

struct SetGame {
    let cards = createCards()
    
    static private func createCards(shuffled: Bool = true) -> [Card] {
        var cards: [Card] = []
        for condition1 in CardCondition.allCases {
            for condition2 in CardCondition.allCases {
                for condition3 in CardCondition.allCases {
                    for condition4 in CardCondition.allCases  {
                        cards.append(
                            Card(condition1, condition2, condition3, condition4)
                        )
                    }
                }
            }
        }
        return shuffled ? cards.shuffled() : cards
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        let condition1: CardCondition
        let condition2: CardCondition
        let condition3: CardCondition
        let condition4: CardCondition
        
        init(_ condition1: CardCondition, _ condition2: CardCondition, _ condition3: CardCondition, _ condition4: CardCondition) {
            self.condition1 = condition1
            self.condition2 = condition2
            self.condition3 = condition3
            self.condition4 = condition4
        }
        
        var id: String {
            return "[\(condition1)-\(condition2)-\(condition3)-\(condition4)]"
        }
        
        var debugDescription: String {
            return id
        }
    }
}
