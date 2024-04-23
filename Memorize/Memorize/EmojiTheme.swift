//
//  EmojiTheme.swift
//  Memorize
//
//  Created by Eliott Radcliffe on 1/12/24.
//

import Foundation

struct EmojiTheme: Codable, Hashable, Identifiable {
    var name: String
    var icon: String
    var emojis: String
    var nPairs: Int
    var cardColor: String
    
    private var uuid = UUID()
    
    var id: String {
        "\(name)-\(icon)-\(emojis)-\(uuid)"
    }
    
    static let new = EmojiTheme(
        name: "New Theme",
        icon: "atom",
        emojis: "",
        nPairs: 0,
        cardColor: "black"
    )
    
    static let builtins = [halloween, hands, sports, flags, tech, animals]
    
    static let halloween = EmojiTheme(
        name: "Halloween",
        icon: "person.2",
        emojis: "👻🎃🕷️👺🏴‍☠️🧌👽💀🧞🤖",
        nPairs: 4,
        cardColor: "orange"
    )
    
    static let hands = EmojiTheme(
        name: "Hands",
        icon: "hand.raised",
        emojis: "🫶🏿👐🏽🫱🏻‍🫲🏽✌️🖖🏻🖕🏾🤌🤙🏼🤜🏿👉🏽",
        nPairs: 5,
        cardColor: "yellow"
    )
    
    static let sports = EmojiTheme(
        name: "Sports",
        icon: "soccerball",
        emojis: "⚽️🏀🏈⚾️🥌🎱🏓🏒⛳️🥊",
        nPairs: 6,
        cardColor: "green"
    )
    
    static let flags = EmojiTheme(
        name: "Flags",
        icon: "flag",
        emojis: "🏳️‍🌈🇧🇷🇨🇦🇭🇷🇯🇵🇪🇸🇬🇧🇺🇸🇵🇹🇨🇴",
        nPairs: 7,
        cardColor: "red"
    )
    
    static let tech = EmojiTheme(
        name: "Tech",
        icon: "computermouse",
        emojis: "🖨️📱🕹️💽💾📼📺📸☎️⏰📡💡",
        nPairs: 8,
        cardColor: "gray"
    )
    
    static let animals = EmojiTheme(
        name: "Animals",
        icon: "lizard",
        emojis: "🐶🐱🐭🐹🐰🦊🐻🐼🐨🐯🐷",
        nPairs: 9,
        cardColor: "blue"
    )
}
