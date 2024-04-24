//
//  EmojiThemeEditor.swift
//  Memorize
//
//  Created by Eliott Radcliffe on 4/23/24.
//

import SwiftUI

struct EmojiThemeEditor: View {
    @Binding var theme: EmojiTheme
    
    init(theme: Binding<EmojiTheme>) {
        _theme = theme
        color = Color(rgba: theme.wrappedValue.cardColor)
    }
    
    @State private var icon = ""
    @State private var iconSelectorMenuIsVisible = false
    @State private var emojisToAdd: String = ""
    @State private var color: Color
    
    enum Focused {
        case name
        case addEmojis
    }
    
    @FocusState private var focused: Focused?
    
    var body: some View {
        Form {
            displaySection
            emojiSection
        }
        .onAppear {
            focused = theme.name.isEmpty || theme.name == "New Theme" ? .name : .addEmojis
        }
    }
    
    // MARK: - Display Section
    
    var displaySection: some View {
        Section(header: Text("Display")) {
            nameTextField
            HStack {
                iconSelector
                Divider()
                colorPicker
                Spacer()
            }
        }
    }
    
    var nameTextField: some View {
        TextField("Name", text: $theme.name)
            .font(.title)
            .focused($focused, equals: .name)
    }
    
    var iconSelector: some View {
        Label {
            Text("Icon")
        } icon: {
            Image(systemName: theme.icon)
                .foregroundColor(theme.color)
        }
        .popover(isPresented: $iconSelectorMenuIsVisible) {
            iconSelectorMenu
        }
        .onTapGesture {
            withAnimation {
                iconSelectorMenuIsVisible = true
            }
        }
    }
    
    var iconSelectorMenu: some View {
        VStack {
            Text("Select an Icon")
                .font(.title)
            LazyVGrid(
                columns: [GridItem(.adaptive(minimum: iconSize))],
                spacing: iconSpacing
            ){
                ForEach(EmojiTheme.availableIcons, id: \.self) { icon in
                    iconSelectorButton(for: icon)
                }
            }
        }
        .frame(width: iconMenuWidth)
        .padding()
    }
    
    @ViewBuilder
    private func iconSelectorButton(for icon: String) -> some View {
        if icon != theme.icon {
            Button {
                withAnimation {
                    theme.icon = icon
                    iconSelectorMenuIsVisible = false
                }
            } label: {
                Image(systemName: icon)
                    .font(.largeTitle)
            }
        }
    }
    
    private var colorPicker: some View {
        ColorPicker("Card Color", selection: $color)
            .onChange(of: color) {
                theme.cardColor = RGBA(color: color)
            }
    }
    
    // MARK: - Emoji Section
    
    private var emojiSection: some View {
        Section(header: Text("Emojis")) {
            numberOfEmojis
            addEmojis
            removeEmojis
        }
    }
    
    private var numberOfEmojis: some View {
        Stepper {
            Text("# of Emojis in Game = \(theme.nPairs)")
        } onIncrement: {
            theme.nPairs = min(theme.emojis.count, theme.nPairs + 1)
        } onDecrement: {
            theme.nPairs = max(2, theme.nPairs - 1)
        }
    }
    
    private var addEmojis: some View {
        TextField("Add Emojis Here", text: $emojisToAdd)
            .focused($focused, equals: .addEmojis)
            .font(emojiFont)
            .onChange(of: emojisToAdd) {
                theme.emojis = (emojisToAdd + theme.emojis)
                    .filter { $0.isEmoji }
                    .uniqued
            }
    }
    
    private var removeEmojis: some View {
        VStack(alignment: .trailing) {
            menuToRemoveEmojis
            if !theme.removedEmojis.isEmpty {
                menuToAddRemovedEmojisBackIn
            }
        }
    }
    
    @ViewBuilder
    private var menuToRemoveEmojis: some View {
        Text("Tap to Remove Emojis")
            .font(.caption)
            .foregroundColor(.gray)
        emojiSelectionGrid(for: theme.emojis) { emoji in
            if let firstCharacter = emoji.first {
                theme.emojis.remove(firstCharacter)
                emojisToAdd.remove(firstCharacter)
                theme.removedEmojis.append(firstCharacter)
            }
        }
    }
    
    @ViewBuilder
    private var menuToAddRemovedEmojisBackIn: some View {
        Text("Removed Emojis (Tap to Add Back)")
            .font(.caption)
            .foregroundColor(.gray)
        emojiSelectionGrid(for: theme.removedEmojis) { emoji in
            if let firstCharacter = emoji.first {
                theme.removedEmojis.remove(firstCharacter)
                theme.emojis = (emoji + theme.emojis)
                    .filter { $0.isEmoji }
                    .uniqued
            }
        }
    }
    
    private func emojiSelectionGrid(for emojis: String, onTapAction: @escaping (String) -> Void) -> some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: iconSize))]) {
            ForEach(emojis.uniqued.map(String.init), id: \.self) { emoji in
                Text(emoji)
                    .font(emojiFont)
                    .onTapGesture {
                        withAnimation {
                            onTapAction(emoji)
                        }
                    }
            }
        }
    }
    
    // MARK: - Constants
    
    private let emojiFont = Font.system(size: 40)
    private let iconSize: CGFloat = 60
    private let iconSpacing: CGFloat = 12
    private let iconMenuWidth: CGFloat = 360
}

/*
#Preview {
    EmojiThemeEditor(theme: EmojiTheme.new)
}
*/
