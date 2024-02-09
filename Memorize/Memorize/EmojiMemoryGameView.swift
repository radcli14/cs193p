//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Eliott Radcliffe on 1/10/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    typealias Card = MemoryGame<String>.Card
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Text(viewModel.themeName)
                .font(.largeTitle)
            /*Button("New Game") {
                viewModel.startNewGame()
            }*/
            cards
            Spacer()
            themeButtons
            Divider()
            HStack {            
                score
                Spacer()
                shuffleButton
            }
            .font(.title)
        }
        .padding()
    }
    
    private var score: some View {
        Text("Score = \(viewModel.score)")
            .animation(nil)
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards,
                    aspectRatio: Constants.aspectRatio
        ) { card in
            CardView(card)
                .padding(Constants.spacing)
                .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                .onTapGesture{
                    withAnimation {
                        viewModel.choose(card)
                    }
                }
        }
        .foregroundColor(viewModel.themeColor)
    }
    
    private func scoreChange(causedBy card: Card) -> Int {
        return 0
    }
    
    private var themeButtons: some View {
        HStack(alignment: .bottom) {
            ForEach(viewModel.themes.indices, id: \.self) { index in
                let theme = viewModel.themes[index]
                Button(action: {
                    viewModel.changeTheme(to: theme)
                }) {
                    VStack {
                        Image(systemName: theme.icon)
                            .imageScale(.large)
                            .font(viewModel.isSelected(theme) ? .title : .body)
                        Text(theme.name)
                            .font(.caption2)
                    }
                    .foregroundColor(viewModel.isSelected(theme) ? .green : .blue)
                    .frame(width: Constants.themeButtonWidth)
                }
            }
        }
    }
    
    private var shuffleButton: some View {
        Button("Shuffle") {
            withAnimation {
                viewModel.shuffle()
            }
        }
    }
    
    private struct Constants {
        static let aspectRatio: CGFloat = 2/3
        static let spacing: CGFloat = 4
        static let themeButtonWidth: CGFloat = 56
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
