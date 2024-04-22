//
//  EmojiThemeStore.swift
//  Memorize
//
//  Created by Eliott Radcliffe on 4/22/24.
//

import Foundation
import SwiftUI

class EmojiThemeStore: ObservableObject {
    let themes = EmojiTheme.builtins
    
    var selectedThemeIndex: Array<EmojiTheme>.Index?
    
    var theme: EmojiTheme? {
        guard let selectedThemeIndex else { return nil }
        return themes[selectedThemeIndex]
    }
    
    var themeName: String? {
        theme?.name
    }
    
    var themeColor: Color {
        theme?.color ?? .gray
    }
    
    func isSelected(_ themeToCheck: EmojiTheme) -> Bool {
        return theme?.id == themeToCheck.id
    }
}

extension EmojiTheme {
    var color: Color {
        switch cardColor.lowercased() {
        case "red": return .red
        case "orange": return .orange
        case "yellow": return .yellow
        case "green": return .green
        case "blue": return .blue
        case "indigo": return .indigo
        case "purple": return .purple
        default: return .gray
        }
    }
}