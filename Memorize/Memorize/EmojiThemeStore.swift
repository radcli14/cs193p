//
//  EmojiThemeStore.swift
//  Memorize
//
//  Created by Eliott Radcliffe on 4/22/24.
//

import Foundation
import SwiftUI

class EmojiThemeStore: ObservableObject {
    @Published var themes = EmojiTheme.builtins
    
    var selectedThemeIndex: Array<EmojiTheme>.Index?
    
    var theme: EmojiTheme? {
        guard let selectedThemeIndex else { return nil }
        return themes[selectedThemeIndex]
    }
    
    var themeName: String? {
        theme?.name
    }
    
    var themeColor: Color {
        if let color = theme?.cardColor {
            return Color(rgba: color)
        }
        return .gray
    }
    
    func isSelected(_ themeToCheck: EmojiTheme) -> Bool {
        return theme?.id == themeToCheck.id
    }
    
    // MARK: - Intents
    
    func newTheme() {
        themes.insert(EmojiTheme.new, at: 0)
    }
    
    func remove(_ theme: EmojiTheme) {
        if let index = themes.firstIndex(where: { $0.id == theme.id }) {
            themes.remove(at: index)
        }
    }
    
    func select(_ theme: EmojiTheme) {
        if let index = themes.firstIndex(where: { $0.id == theme.id }) {
            selectedThemeIndex = index
        }
    }
    
    func unselectTheme() {
        selectedThemeIndex = nil
    }
}

extension EmojiTheme {
    var color: Color {
        Color(rgba: cardColor)
    }
}

extension Color {
    init(rgba: RGBA) {
        self.init(.sRGB, red: rgba.red, green: rgba.green, blue: rgba.blue, opacity: rgba.alpha)
    }
}

extension RGBA {
    init(color: Color) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        UIColor(color).getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        self.init(red: Double(red), green: Double(green), blue: Double(blue), alpha: Double(alpha))
    }
}
