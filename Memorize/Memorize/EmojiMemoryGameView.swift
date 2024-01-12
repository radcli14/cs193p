//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Eliott Radcliffe on 1/10/24.
//

import SwiftUI

enum CardTheme: CaseIterable {
    case halloween
    case hands
    case sports
    
    var name: String {
        switch self {
        case .halloween: "Halloween"
        case .hands: "Hands"
        case .sports: "Sports"
        }
    }
    
    var icon: String {
        switch self {
        case .halloween: "person.2"
        case .hands: "hand.raised"
        case .sports: "soccerball"
        }
    }
    
    var emojis: [String] {
        switch self {
        case .halloween: ["👻", "🎃", "🕷️", "👺", "🏴‍☠️", "🧌", "👽", "💀", "🧞", "🤖"]
        case .hands: ["🫶🏿", "👐🏽", "🫱🏻‍🫲🏽", "✌️", "🖖🏻", "🖕🏾", "🤌", "🤙🏼", "🤜🏿", "👉🏽"]
        case .sports: ["⚽️", "🏀", "🏈", "⚾️", "🥌", "🎱", "🏓", "🏒", "⛳️", "🥊"]
        }
        
    }
}


struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    /*@State var theme: CardTheme = .halloween
    var emojis: [String] {
        return theme.emojis + theme.emojis
    }*/
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            ScrollView {
                cards
            }
            Spacer()
            Button("Shuffle") {
                viewModel.shuffle()
            }
            //themeButtons
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards.indices, id: \.self) { index in
                CardView(viewModel.cards[index])
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
            }
        }
        .foregroundColor(.green)
    }
    
    /*
    var themeButtons: some View {
        HStack(alignment: .bottom) {
            ForEach(CardTheme.allCases, id: \.self) { buttonTheme in
                Button(action: {
                    theme = buttonTheme
                }) {
                    VStack {
                        Image(systemName: buttonTheme.icon)
                            .imageScale(.large)
                            .font(.title)
                        Text(buttonTheme.name)
                            .font(.callout)
                    }
                    .frame(width: 96)
                }
            }
        }
    }
     */
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
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
        /*.onTapGesture {
            isFaceUp.toggle()
        }*/
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
