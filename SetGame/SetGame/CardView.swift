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
        case .diamond:
            Diamond()
                .stroke(color, lineWidth: Constants.lineWidth)
                .fill(cardFill)
        case .squiggle:
            Squiggle()
                .stroke(color, lineWidth:  Constants.lineWidth)
                .fill(cardFill)
        case .oval:
            Ellipse()
                .stroke(color, lineWidth:  Constants.lineWidth)
                .fill(cardFill)
        }
    }
    
   private var color: Color {
        switch card.color {
        case .red: Color.red
        case .green: Color.green
        case .purple: Color.purple
        }
    }
    
    private var cardFill: Color {
        switch card.shading {
        case .solid: color
        case .striped: color.opacity(0.25)
        case .open: Color.white
        }
    }
    
    private struct Constants {
        static let aspectRatio: CGFloat = 2
        static let lineWidth: CGFloat = 5
    }
}



#Preview {
    CardView(ShapeSetGame().cards.first!)
}
