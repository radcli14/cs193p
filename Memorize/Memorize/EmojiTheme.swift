//
//  EmojiTheme.swift
//  Memorize
//
//  Created by Eliott Radcliffe on 1/12/24.
//

import Foundation

protocol EmojiTheme {
    var name: String { get }
    var icon: String { get }
    var emojis: [String] { get }
}

struct HalloweenTheme: EmojiTheme {
    let name = "Halloween"
    let icon = "person.2"
    let emojis = ["👻", "🎃", "🕷️", "👺", "🏴‍☠️", "🧌", "👽", "💀", "🧞", "🤖"]
}

struct HandsTheme: EmojiTheme {
    let name = "Hands"
    let icon = "hand.raised"
    let emojis = ["🫶🏿", "👐🏽", "🫱🏻‍🫲🏽", "✌️", "🖖🏻", "🖕🏾", "🤌", "🤙🏼", "🤜🏿", "👉🏽"]
}

struct SportsTheme: EmojiTheme {
    let name = "Sports"
    let icon = "soccerball"
    let emojis = ["⚽️", "🏀", "🏈", "⚾️", "🥌", "🎱", "🏓", "🏒", "⛳️", "🥊"]
}
/*
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
*/
