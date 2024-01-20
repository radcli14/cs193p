//
//  SetGame.swift
//  SetGame
//
//  Created by Eliott Radcliffe on 1/20/24.
//

import Foundation

enum CardCondition {
    case one
    case two
    case three
}

struct SetGame {
    
    struct Card: Equatable, Identifiable {
        let condition1: CardCondition
        let condition2: CardCondition
        let condition3: CardCondition
        let condition4: CardCondition
        
        var id: String {
            return "\(condition1) \(condition2) \(condition3) \(condition4)"
        }
    }
}
