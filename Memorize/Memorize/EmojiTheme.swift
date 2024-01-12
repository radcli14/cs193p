//
//  EmojiTheme.swift
//  Memorize
//
//  Created by Eliott Radcliffe on 1/12/24.
//

import Foundation

enum CardTheme: CaseIterable {
    case halloween
    case hands
    case sports
    
    var name: String {
        switch self {
        case .halloween: "Halloween"
        case .hands: "Hands"
        case .sports: "Sports"
        }
    }
    
    var icon: String {
        switch self {
        case .halloween: "person.2"
        case .hands: "hand.raised"
        case .sports: "soccerball"
        }
    }
    
    var emojis: [String] {
        switch self {
        case .halloween: ["👻", "🎃", "🕷️", "👺", "🏴‍☠️", "🧌", "👽", "💀", "🧞", "🤖"]
        case .hands: ["🫶🏿", "👐🏽", "🫱🏻‍🫲🏽", "✌️", "🖖🏻", "🖕🏾", "🤌", "🤙🏼", "🤜🏿", "👉🏽"]
        case .sports: ["⚽️", "🏀", "🏈", "⚾️", "🥌", "🎱", "🏓", "🏒", "⛳️", "🥊"]
        }
    }
}
