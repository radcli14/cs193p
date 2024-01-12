//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Eliott Radcliffe on 1/10/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            ScrollView {
                cards
            }
            Spacer()
            themeButtons
            Divider()
            shuffleButton
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards.indices, id: \.self) { index in
                CardView(viewModel.cards[index]) {
                    viewModel.choose(index)
                }
                .aspectRatio(2/3, contentMode: .fit)
                .padding(4)
            }
        }
        .foregroundColor(.green)
    }
    
    var themeButtons: some View {
        HStack(alignment: .bottom) {
            ForEach(viewModel.themes.indices, id: \.self) { index in
                let theme = viewModel.themes[index]
                Button(action: {
                    viewModel.changeTheme(to: theme)
                }) {
                    VStack {
                        Image(systemName: theme.icon)
                            .imageScale(.large)
                            .font(.title)
                        Text(theme.name)
                            .font(.callout)
                    }
                    .frame(width: 96)
                }
            }
        }
    }
    
    var shuffleButton: some View {
        Button("Shuffle") {
            viewModel.shuffle()
        }
        .font(.headline)
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    let onTapGesture: () -> Void
    
    init(_ card: MemoryGame<String>.Card, onTapGesture: @escaping () -> Void) {
        self.card = card
        self.onTapGesture = onTapGesture
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            onTapGesture()
        }
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}