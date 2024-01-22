//
//  CardView.swift
//  SetGame
//
//  Created by Eliott Radcliffe on 1/20/24.
//

import SwiftUI

struct CardView: View {
    let card: SetGame.Card
    
    init(_ card: SetGame.Card) {
        self.card = card
    }
    
    var body: some View {
        shape
            .foregroundColor(color)
            .aspectRatio(Constants.aspectRatio, contentMode: .fit)
            .cardify(n: card.n, isFaceUp: true)
    }
    
    @ViewBuilder
    private var shape: some View {
        switch card.typeOfShape {
        case .diamond: Diamond()
        case .squiggle: Squiggle()
        case .oval: Ellipse()
        }
    }
    
   private var color: Color {
        switch card.color {
        case .red: Color.red
        case .green: Color.green
        case .purple: Color.purple
        }
    }
    
    private struct Constants {
        static let aspectRatio: CGFloat = 2
    }
}

#Preview {
    CardView(ShapeSetGame().cards.first!)
}
