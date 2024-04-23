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
    
    @State private var emojisToAdd: String = ""
    @State private var color: Color
    
    enum Focused {
        case name
        case addEmojis
    }
    
    @FocusState private var focused: Focused?
    
    var body: some View {
        Form {
            nameSection
            emojiSection
        }
        .onAppear {
            focused = theme.name.isEmpty || theme.name == "New Theme" ? .name : .addEmojis
        }
    }
    
    var nameSection: some View {
        Section(header: Text("Display")) {
            TextField("Name", text: $theme.name)
                .font(.title)
                .focused($focused, equals: .name)
            ColorPicker("Card Color", selection: $color)
                .onChange(of: color) {
                    theme.cardColor = RGBA(color: color)
                }
        }
    }
    
    // MARK: - Emoji Section
    
    var emojiSection: some View {
        Section(header: Text("Emojis")) {
            numberOfEmojis
            addEmojis
            removeEmojis
        }
    }
    
    var numberOfEmojis: some View {
        Stepper {
            Text("# of Emojis in Game = \(theme.nPairs)")
        } onIncrement: {
            theme.nPairs = min(theme.emojis.count, theme.nPairs + 1)
        } onDecrement: {
            theme.nPairs = max(2, theme.nPairs - 1)
        }
    }
    
    var addEmojis: some View {
        TextField("Add Emojis Here", text: $emojisToAdd)
            .focused($focused, equals: .addEmojis)
            .font(emojiFont)
            .onChange(of: emojisToAdd) {
                theme.emojis = (emojisToAdd + theme.emojis)
                    .filter { $0.isEmoji }
                    .uniqued
            }
    }
    
    var removeEmojis: some View {
        VStack(alignment: .trailing) {
            Text("Tap to Remove Emojis")
                .font(.caption)
                .foregroundColor(.gray)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {
                ForEach(theme.emojis.uniqued.map(String.init), id: \.self) { emoji in
                    Text(emoji)
                        .font(emojiFont)
                        .onTapGesture {
                            withAnimation {
                                theme.emojis.remove(emoji.first!)
                                emojisToAdd.remove(emoji.first!)
                            }
                        }
                }
            }
        }
    }
    
    // MARK: - Constants
    
    private let emojiFont = Font.system(size: 40)
}

/*
#Preview {
    EmojiThemeEditor(theme: EmojiTheme.new)
}
*/
