//
//  EmojiThemeStore.swift
//  Memorize
//
//  Created by Eliott Radcliffe on 4/22/24.
//

import Foundation
import SwiftUI

/// Persistence for the list of `EmojiTheme`
extension [EmojiTheme] {
    func json() throws -> Data {
        let encoded = try JSONEncoder().encode(self)
        print("Themes = \(String(data: encoded, encoding: .utf8) ?? "nil")")
        return encoded
    }
    
    init(json: Data) throws {
        self = try JSONDecoder().decode([EmojiTheme].self, from: json)
    }
}

class EmojiThemeStore: ObservableObject {
    init() {
        if let data = try? Data(contentsOf: autosaveURL),
            let autosavedThemes = try? [EmojiTheme](json: data) {
            themes = autosavedThemes
        }
    }
    
    @Published var themes = EmojiTheme.builtins {
        didSet {
            autosave()
        }
    }
    
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
    
    // MARK: - Persistence
    
    private let autosaveURL: URL = URL.documentsDirectory.appendingPathComponent("Autosaved.emojithemes")
    
    private func autosave() {
        save(to: autosaveURL)
        print("autosaved to \(autosaveURL)")
    }
    
    private func save(to url: URL) {
        do {
            let data = try themes.json()
            try data.write(to: url)
        } catch let error {
            print("Themes: error while saving \(error.localizedDescription)")
        }
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
