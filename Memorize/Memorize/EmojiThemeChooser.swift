//
//  EmojiThemeChooser.swift
//  Memorize
//
//  Created by Eliott Radcliffe on 4/22/24.
//

import SwiftUI

struct EmojiThemeChooser: View {
    @ObservedObject var viewModel: EmojiThemeStore
    @State private var showThemeEditor = false
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            themeList
                .navigationDestination(for: EmojiTheme.ID.self) { themeId in
                    gameView(for: themeId)
                }
                .navigationTitle("Themes")
                .toolbar {
                    newThemeButton
                }
        }
        .sheet(isPresented: $showThemeEditor, onDismiss: {
            viewModel.unselectTheme()
        }) {
            if let index = viewModel.selectedThemeIndex {
                EmojiThemeEditor(theme: $viewModel.themes[index])
            }
        }
    }
    
    private var themeList: some View {
        List {
            ForEach(viewModel.themes) { theme in
                NavigationLink(value: theme.id) {
                    menuContent(for: theme)
                        .tag(theme)
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            deleteThemeSwipeActionButton(for: theme)
                            editThemeSwipeActionButton(for: theme)
                        }
                }
            }
        }
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
                Text(theme.emojis)
                    .font(.title3)
                    .lineLimit(1)
            }
            .padding()
        }
    }
    
    @ViewBuilder
    private func gameView(for themeId: EmojiTheme.ID) -> some View {
        if let index = viewModel.themes.firstIndex(where: { $0.id == themeId }) {
            EmojiMemoryGameView(
                viewModel: EmojiMemoryGame(theme: viewModel.themes[index]),
                cardColor: viewModel.themes[index].color
            )
            .navigationTitle(viewModel.themes[index].name)
        }
    }
    
    // MARK: - Buttons
    
    private var newThemeButton: some View {
        Button(action: {
            withAnimation {
                viewModel.newTheme()
            }
        }) {
            HStack {
                Image(systemName: "plus")
                Text("Add Theme")
            }
        }
    }
    
    private func deleteThemeSwipeActionButton(for theme: EmojiTheme) -> some View {
        Button(role: .destructive) {
            withAnimation {
                viewModel.remove(theme)
            }
        } label: {
            Label("Delete", systemImage: "trash")
        }
    }
    
    private func editThemeSwipeActionButton(for theme: EmojiTheme) -> some View {
        Button {
            viewModel.select(theme)
            showThemeEditor = true
        } label: {
            Label("Edit", systemImage: "pencil")
        }
    }
    
    // MARK: - Constants
    
    private struct Constants {
        static let iconSize: CGFloat = 36
    }
}

#Preview {
    EmojiThemeChooser(viewModel: EmojiThemeStore())
}
