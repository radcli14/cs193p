//
//  EmojiTheme.swift
//  Memorize
//
//  Created by Eliott Radcliffe on 1/12/24.
//

import Foundation


struct RGBA: Codable, Equatable, Hashable {
    let red: Double
    let green: Double
    let blue: Double
    let alpha: Double
    
    init(red: Double, green: Double, blue: Double, alpha: Double) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
    
    init(red: Int, green: Int, blue: Int) {
        self.red = Double(red) / 255.0
        self.green = Double(green) / 255.0
        self.blue = Double(blue) / 255.0
        self.alpha = 1.0
    }
}

struct EmojiTheme: Codable, Hashable, Identifiable {
    var name: String
    var icon: String
    var emojis: String
    var nPairs: Int
    var cardColor: RGBA
    
    private var uuid = UUID()
    
    var id: String {
        "\(name)-\(icon)-\(emojis)-\(uuid)"
    }
    
    static let new = EmojiTheme(
        name: "New Theme",
        icon: "atom",
        emojis: "",
        nPairs: 0,
        cardColor: RGBA(red: 0, green: 0, blue: 0)
    )
    
    static let builtins = [halloween, hands, sports, flags, tech, animals]
    
    static let halloween = EmojiTheme(
        name: "Halloween",
        icon: "person.2",
        emojis: "👻🎃🕷️👺🏴‍☠️🧌👽💀🧞🤖",
        nPairs: 4,
        cardColor: RGBA(red: 255, green: 149, blue: 0)
    )
    
    static let hands = EmojiTheme(
        name: "Hands",
        icon: "hand.raised",
        emojis: "🫶🏿👐🏽🫱🏻‍🫲🏽✌️🖖🏻🖕🏾🤌🤙🏼🤜🏿👉🏽",
        nPairs: 5,
        cardColor: RGBA(red: 255, green: 204, blue: 0)
    )
    
    static let sports = EmojiTheme(
        name: "Sports",
        icon: "soccerball",
        emojis: "⚽️🏀🏈⚾️🥌🎱🏓🏒⛳️🥊",
        nPairs: 6,
        cardColor: RGBA(red: 52, green: 189, blue: 89)
    )
    
    static let flags = EmojiTheme(
        name: "Flags",
        icon: "flag",
        emojis: "🏳️‍🌈🇧🇷🇨🇦🇭🇷🇯🇵🇪🇸🇬🇧🇺🇸🇵🇹🇨🇴",
        nPairs: 7,
        cardColor: RGBA(red: 255, green: 59, blue: 48)
    )
    
    static let tech = EmojiTheme(
        name: "Tech",
        icon: "computermouse",
        emojis: "🖨️📱🕹️💽💾📼📺📸☎️⏰📡💡",
        nPairs: 8,
        cardColor: RGBA(red: 142, green: 142, blue: 87)
    )
    
    static let animals = EmojiTheme(
        name: "Animals",
        icon: "lizard",
        emojis: "🐶🐱🐭🐹🐰🦊🐻🐼🐨🐯🐷",
        nPairs: 9,
        cardColor: RGBA(red: 0, green: 122, blue: 255)
    )
    
    static let availableIcons = [
        "scribble.variable",
        "pencil.tip.crop.circle",
        "paperplane.fill",
        "doc",
        "lizard",
        "computermouse",
        "flag",
        "soccerball",
        "hand.raised",
        "person.2",
        "atom",
        "pencil.and.list.clipboard",
        "book",
        "books.vertical",
        "graduationcap",
        "photo.artframe",
        "figure.fall",
        "figure.hockey",
        "sportscourt",
        "globe.americas",
        "sun.max",
        "sparkles",
        "cloud.bolt",
        "hurricane",
        "flame",
        "umbrella",
        "infinity",
        "music.note.list",
        "app.gift",
        "fleuron",
        "flag.checkered"
    ]
}
