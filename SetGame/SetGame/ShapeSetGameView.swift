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
    
    var body: some View {
        VStack {
            Text("SET!").font(.largeTitle)
            visibleCards
            HStack {
                deck
                Spacer()
                discarded
            }
            .padding()
            Divider()
            HStack {
                deal3Button
                Spacer()
                newGameButton
            }
            .font(.title2)
        }
        .padding()
    }
    
    private var deck: some View {
        VStack {
            stackOfCards(viewModel.deck, withCount: true)
            textBelowStackOfCards("Deck")
        }
        .onTapGesture {
            withAnimation {
                if viewModel.visibleCards.isEmpty {
                    viewModel.deal()
                } else {
                    viewModel.deal3()
                }
            }
        }
    }
    
    private var visibleCards: some View {
        AspectVGrid(
            Array(viewModel.visibleCards),
            aspectRatio: Constants.aspectRatio
        ) { card in
            CardView(card)
                .padding(Constants.paddingAroundCards)
                .onTapGesture {
                    withAnimation {
                        viewModel.choose(card)
                    }
                }
        }
    }
    
    private var discarded: some View {
        VStack {
            stackOfCards(viewModel.discarded)
            textBelowStackOfCards("Discard")
        }
    }
    
    func stackOfCards(_ cards: [Card], withCount: Bool = false) -> some View {
        ZStack {
            ForEach(cards) { card in
                CardView(card)
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
    
    private var deal3Button: some View {
        Button("Deal 3") {
            withAnimation {
                viewModel.deal3()
            }
        }
    }
    
    private var newGameButton: some View {
        Button("New Game") {
            withAnimation {
                viewModel.newGame()
            }
        }
    }
    
    // MARK: Constants
    
    private struct Constants {
        static let aspectRatio: CGFloat = 2/3
        static let paddingAroundCards: CGFloat = 4
        static let deckAndDiscardWidth: CGFloat = 60
    }
}

#Preview {
    ShapeSetGameView(viewModel: ShapeSetGame())
}
