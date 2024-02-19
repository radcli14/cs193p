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
        shapeStack
            .foregroundColor(color)
            .cardify(isFaceUp: card.isFaceUp, isSelected: card.isChosen, isMatched: card.isMatched)
    }
    
    private var shapeStack: some View {
        GeometryReader { geometry in
            VStack(spacing: geometry.size.height * Constants.spacingRatio) {
                ForEach(0..<card.n, id: \.self) { _ in
                    shape.aspectRatio(Constants.aspectRatioForShape, contentMode: .fit)
                }
            }
            .frame(maxHeight: .infinity)
            .padding(geometry.size.width * Constants.paddingRatio)
        }
    }
    
    @ViewBuilder
    private var shape: some View {
        GeometryReader { geometry in
            switch card.typeOfShape {
            case .diamond:
                Diamond()
                    .stroke(color, lineWidth: geometry.size.width * Constants.lineWidthRatio)
                    .fill(cardFill)
            case .squiggle:
                Squiggle()
                    .stroke(color, lineWidth: geometry.size.width * Constants.lineWidthRatio)
                    .fill(cardFill)
            case .oval:
                Ellipse()
                    .stroke(color, lineWidth: geometry.size.width * Constants.lineWidthRatio)
                    .fill(cardFill)
            }

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
        static let aspectRatioForShape: CGFloat = 2
        static let lineWidthRatio: CGFloat = 0.1
        static let spacingRatio: CGFloat = 0.05
        static let paddingRatio: CGFloat = 0.15
    }
}

#Preview {
    CardView(SetGame.Card(.three, .diamond, .open, .green, isFaceUp: true))
}
