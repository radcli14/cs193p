//
//  EmojiThemeChooser.swift
//  Memorize
//
//  Created by Eliott Radcliffe on 4/22/24.
//

import SwiftUI

struct EmojiThemeChooser: View {
    @ObservedObject var viewModel: EmojiThemeStore
    @State var selectedTheme: EmojiTheme?
    @StateObject var game = EmojiMemoryGame()
    
    var body: some View {
        NavigationStack {
            themeList
        }
    }
    
    private var themeList: some View {
        List {
            ForEach(viewModel.themes) { theme in
                NavigationLink(value: theme.id) {
                    menuContent(for: theme)
                        .tag(theme)
                }
            }
        }
        .navigationDestination(for: EmojiTheme.ID.self) { themeId in
            if let index = viewModel.themes.firstIndex(where: { $0.id == themeId }) {
                EmojiMemoryGameView(
                    viewModel: EmojiMemoryGame(theme: viewModel.themes[index]), 
                    cardColor: viewModel.themes[index].color
                )
                .navigationTitle(viewModel.themes[index].name)
            }
        }
        .navigationTitle("Themes")
    }
    
    private func menuContent(for theme: EmojiTheme) -> some View {
        HStack {
            Image(systemName: theme.icon)
                .foregroundColor(theme.color)
                .font(.largeTitle)
                .frame(width: Constants.iconSize, height: Constants.iconSize)
            VStack(alignment: .leading) {
                Text(theme.name)
                    .font(.title)
                Text(theme.emojis.joined())
                    .font(.title3)
                    .lineLimit(1)
            }
            .padding()
        }
    }
    
    private struct Constants {
        static let iconSize: CGFloat = 36
    }
}

#Preview {
    EmojiThemeChooser(viewModel: EmojiThemeStore())
}
