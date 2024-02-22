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
            cards
            Spacer()
            themeButtons
            Divider()
            HStack(alignment: .center) {            
                score
                Spacer()
                shuffleButton
            }
            .overlay {
                deck.foregroundColor(viewModel.themeColor)
            }
            .font(.title3)
            .padding()
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
            if isDealt(card) {
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
                    .padding(Constants.spacing)
                    .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                    .zIndex(scoreChange(causedBy: card) != 0 ? 100 : 0)
                    .onTapGesture{
                        choose(card)
                    }
            }
        }
        .foregroundColor(viewModel.themeColor)
    }
    
    @State private var dealt = Set<Card.ID>()
    
    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    
    private var undealtCards: [Card] {
        viewModel.cards.filter { !isDealt($0) }
    }
    
    @Namespace private var dealingNamespace
    
    private var deck: some View {
        ZStack {
            ForEach(undealtCards) { card in
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
            }
            if !undealtCards.isEmpty {
                Text("Deal!")
                    .foregroundColor(.white)
                    .font(.callout)
            }
        }
        .frame(width: Constants.deckWidth, height: Constants.deckWidth / Constants.aspectRatio)
        .onTapGesture {
            deal()
        }
    }
    
    private func deal() {
        var delay: TimeInterval = 0
        for card in viewModel.cards {
            withAnimation(Constants.dealAnimation.delay(delay)) {
                _ = dealt.insert(card.id)
            }
            delay += Constants.dealInterval
        }
    }
    
    private func choose(_ card: Card) {
        withAnimation {
            let scoreBeforeChoosing = viewModel.score
            viewModel.choose(card)
            let scoreChange = viewModel.score - scoreBeforeChoosing
            lastScoreChange = (scoreChange, causedByCardId: card.id)
        }
    }
    
    @State private var lastScoreChange = (0, causedByCardId: "")
    
    private func scoreChange(causedBy card: Card) -> Int {
        let (amount, causedByCardId) = lastScoreChange
        return card.id == causedByCardId ? amount : 0
    }
    
    private var themeButtons: some View {
        HStack(alignment: .bottom, spacing: 0.0) {
            ForEach(viewModel.themes.indices, id: \.self) { index in
                let theme = viewModel.themes[index]
                Button(action: {
                    viewModel.changeTheme(to: theme)
                    dealt = Set<Card.ID>()
                }) {
                    themeButtonIconAndTextStack(for: theme)    
                }
            }
        }
    }
    
    private func themeButtonIconAndTextStack(for theme: EmojiTheme) -> some View {
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
        static let themeButtonWidth: CGFloat = 64
        static let deckWidth: CGFloat = 50
        static let dealInterval: TimeInterval = 0.15
        static let dealAnimation: Animation = .easeInOut(duration: 1)
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
