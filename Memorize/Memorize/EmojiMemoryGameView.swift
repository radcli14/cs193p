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
    var viewModel: EmojiMemoryGame
    
    @State var theme: CardTheme = .halloween
    var emojis: [String] {
        return theme.emojis + theme.emojis
    }
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            ScrollView {
                cards
            }
            Spacer()
            themeButtons
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
            ForEach(emojis.indices.shuffled(), id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.green)
    }
    
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
}

struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = false
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    EmojiMemoryGameView()
}
