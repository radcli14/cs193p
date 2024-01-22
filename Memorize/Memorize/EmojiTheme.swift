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
    var nPairs: Int { get }
    var cardColor: String { get }
}

struct HalloweenTheme: EmojiTheme {
    let name = "Halloween"
    let icon = "person.2"
    let emojis = ["👻", "🎃", "🕷️", "👺", "🏴‍☠️", "🧌", "👽", "💀", "🧞", "🤖"]
    let nPairs = 2
    let cardColor = "orange"
}

struct HandsTheme: EmojiTheme {
    let name = "Hands"
    let icon = "hand.raised"
    let emojis = ["🫶🏿", "👐🏽", "🫱🏻‍🫲🏽", "✌️", "🖖🏻", "🖕🏾", "🤌", "🤙🏼", "🤜🏿", "👉🏽"]
    let nPairs = 5
    let cardColor = "yellow"
}

struct SportsTheme: EmojiTheme {
    let name = "Sports"
    let icon = "soccerball"
    let emojis = ["⚽️", "🏀", "🏈", "⚾️", "🥌", "🎱", "🏓", "🏒", "⛳️", "🥊"]
    let nPairs = 6
    let cardColor = "green"
}

struct FlagTheme: EmojiTheme {
    let name = "Flags"
    let icon = "flag"
    let emojis = ["🏳️‍🌈", "🇧🇷", "🇨🇦", "🇭🇷", "🇯🇵", "🇪🇸", "🇬🇧", "🇺🇸", "🇵🇹", "🇨🇴"]
    let nPairs = 7
    let cardColor = "red"
}

struct TechTheme: EmojiTheme {
    let name = "Tech"
    let icon = "computermouse"
    let emojis = ["🖨️", "📱", "🕹️", "💽", "💾", "📼", "📺", "📸", "☎️", "⏰", "📡", "💡"]
    let nPairs = 8
    let cardColor = "gray"
}

struct AnimalTheme: EmojiTheme {
    let name = "Animals"
    let icon = "lizard"
    let emojis = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🐷"]
    let nPairs = 9
    let cardColor = "blue"
}
