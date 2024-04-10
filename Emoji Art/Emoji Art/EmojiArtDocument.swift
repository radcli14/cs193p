//
//  EmojiArtDocument.swift
//  Emoji Art
//
//  Created by Eliott Radcliffe on 4/1/24.
//

import SwiftUI

class EmojiArtDocument: ObservableObject {
    typealias Emoji = EmojiArt.Emoji
    @Published private var emojiArt = EmojiArt()
    @Published private(set) var selectedEmojis = Set<Emoji.ID>()

    init() {
        //emojiArt.addEmoji("🇺🇸", at: .init(x: -200, y: -150), size: 200)
        //emojiArt.addEmoji("🇪🇸", at: .init(x: 250, y: 100), size: 80)
    }

    var emojis: [Emoji] {
        emojiArt.emojis
    }
    
    var background: URL? {
        emojiArt.background
    }
    
    // MARK: - Intents
    
    func setBackground(_ url: URL?) {
        emojiArt.background = url
    }
    
    func addEmoji(_ emoji: String, at position: Emoji.Position, size: CGFloat) {
        emojiArt.addEmoji(emoji, at: position, size: Int(size))
    }
    
    func delete(_ emoji: Emoji) {
        emojiArt.remove(emoji)
        selectedEmojis.remove(emoji.id)
    }
    
    func move(_ emoji: Emoji, by offset: CGOffset, multiplier: CGFloat = CGFloat(1)) {
        emojiArt[emoji].move(by: offset, multiplier: multiplier)
    }
    
    func move(emojiWithId id: Emoji.ID, by offset: CGOffset, multiplier: CGFloat = CGFloat(1)) {
        if let emoji = emojiArt[id] {
            move(emoji, by: offset, multiplier: multiplier)
        }
    }
    
    func resize(_ emoji: Emoji, by scale: CGFloat) {
        emojiArt[emoji].size = Int(CGFloat(emojiArt[emoji].size) * scale)
    }
    
    func resize(emojiWithId id: Emoji.ID, by scale: CGFloat) {
        if let emoji = emojiArt[id] {
            resize(emoji, by: scale)
        }
    }
    
    func toggleEmojiSelection(of emoji: Emoji) {
        if isSelected(emoji) {
            selectedEmojis.remove(emoji.id)
        } else {
            selectedEmojis.insert(emoji.id)
        }
    }
    
    func isSelected(_ emoji: Emoji) -> Bool {
        return selectedEmojis.contains(emoji.id)
    }
    
    func deselectAllEmojis() {
        selectedEmojis.removeAll()
    }
    
    var zeroEmojisAreSelected: Bool {
        selectedEmojis.isEmpty
    }
    
    var someEmojisAreSelected: Bool {
        !zeroEmojisAreSelected
    }
}

extension EmojiArt.Emoji {
    var font: Font {
        Font.system(size: CGFloat(size))
    }
    
    func isSelected(in viewModel: EmojiArtDocument) -> Bool {
        return viewModel.isSelected(self)
    }
    
    mutating func move(by offset: CGOffset, multiplier: CGFloat = CGFloat(1)) {
        self.position = self.moved(by: offset, multiplier: multiplier)
    }
    
    func moved(by offset: CGOffset, multiplier: CGFloat = CGFloat(1)) -> EmojiArt.Emoji.Position {
        EmojiArt.Emoji.Position(
            x: self.position.x + Int(multiplier * offset.width),
            y: self.position.y - Int(multiplier * offset.height)
        )
    }
    
}

extension EmojiArt.Emoji.Position {
    func `in`(_ geometry: GeometryProxy) -> CGPoint {
        let center = geometry.frame(in: .local).center
        return CGPoint(
            x: center.x + CGFloat(x),
            y: center.y - CGFloat(y)
        )
    }
}
