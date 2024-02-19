//
//  ContentView.swift
//  SetGame
//
//  Created by Eliott Radcliffe on 1/20/24.
//

import SwiftUI

struct ShapeSetGameView: View {
    @ObservedObject var viewModel: ShapeSetGame
    
    typealias Card = SetGame.Card
    @Namespace private var dealingNamespace
    @Namespace private var discardingNamespace
    
    var body: some View {
        VStack {
            visibleCards
            HStack {
                deck
                Spacer()
                newGameButton
                Spacer()
                discarded
            }
            .padding()
            //Divider()
            
        }
        .padding()
    }
    
    private var deck: some View {
        VStack {
            stackOfCards(viewModel.deck, namespace: dealingNamespace, withCount: true)
            textBelowStackOfCards("Deck")
        }
        .onTapGesture {
            if viewModel.visibleCards.isEmpty {
                viewModel.deal()
            } else {
                viewModel.deal3()
            }
            animateNewlyDealtCards()
        }
    }
    
    @State private var dealt = [Card.ID]() // Set<Card.ID>()
    
    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    
    private var undealtCards: [Card] {
        viewModel.cards.filter { !isDealt($0) }
    }
    
    private var visibleCards: some View {
        AspectVGrid(
            Array(viewModel.visibleCards),
            aspectRatio: Constants.aspectRatio
        ) { card in
            if isDealt(card) {
                CardView(card)
                    .padding(Constants.paddingAroundCards)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
                    .matchedGeometryEffect(id: card.id, in: discardingNamespace)
                    .onTapGesture {
                        withAnimation {
                            viewModel.choose(card)
                        }
                        animateNewlyDealtCards()
                    }
            } else {
                Color.clear
            }
        }
    }
    
    private func animateNewlyDealtCards() {
        var delay: TimeInterval = 0
        for (idx, card) in viewModel.visibleCards.enumerated() {
            if !isDealt(card) {
                withAnimation(Constants.dealAnimation.delay(delay)) {
                    dealt.insert(card.id, at: idx)
                }
                delay += Constants.dealInterval
            }
        }
    }
    
    private var discarded: some View {
        VStack {
            stackOfCards(viewModel.discarded, namespace: discardingNamespace)
            textBelowStackOfCards("Discard")
        }
    }
    
    func stackOfCards(_ cards: [Card], namespace: Namespace.ID, withCount: Bool = false) -> some View {
        ZStack {
            ForEach(cards) { card in
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: namespace)
            }
        }
        .frame(
            width: Constants.deckAndDiscardWidth,
            height: Constants.deckAndDiscardWidth / Constants.aspectRatio
        )
        .overlay {
            if withCount {
                Text(cards.count, format: .number)
                    .foregroundColor(.accentColor)
                    .font(.title)
                    .fontWeight(.bold)
            }
        }
    }
    
    func textBelowStackOfCards(_ text: String) -> some View {
        Text(text).font(.headline)
    }
    
    // MARK: Buttons
    
    private var newGameButton: some View {
        Button("New Game") {
            withAnimation {
                viewModel.newGame()
                dealt = []
            }
        }
        .font(.title2)
    }
    
    // MARK: Constants
    
    private struct Constants {
        static let aspectRatio: CGFloat = 2/3
        static let paddingAroundCards: CGFloat = 4
        static let deckAndDiscardWidth: CGFloat = 60
        static let dealInterval: TimeInterval = 0.15
        static let dealAnimation: Animation = .easeInOut(duration: 1)
    }
}

#Preview {
    ShapeSetGameView(viewModel: ShapeSetGame())
}
