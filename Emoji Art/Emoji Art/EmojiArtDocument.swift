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
    @Published private var selectedEmojis = Set<Emoji.ID>()

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
    
    func move(_ emoji: Emoji, by offset: CGOffset) {
        let existingPosition = emojiArt[emoji].position
        emojiArt[emoji].position = Emoji.Position(
            x: existingPosition.x + Int(offset.width),
            y: existingPosition.y - Int(offset.height)
        )
    }
    
    func move(emojiWithId id: Emoji.ID, by offset: CGOffset) {
        if let emoji = emojiArt[id] {
            move(emoji, by: offset)
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
}

extension EmojiArt.Emoji.Position {
    func `in`(_ geometry: GeometryProxy) -> CGPoint {
        let center = geometry.frame(in: .local).center
        return CGPoint(x: center.x + CGFloat(x), y: center.y - CGFloat(y))
    }
}
