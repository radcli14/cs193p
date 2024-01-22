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
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.gray)
            VStack {
                ForEach(0..<card.n, id: \.self) { _ in
                    shape
                        .foregroundColor(color)
                        .aspectRatio(2, contentMode: .fit)
                        //.padding(12)
                }
            }
            //.padding(12)
        }
    }
    
    @ViewBuilder
    var shape: some View {
        switch card.typeOfShape {
        case .diamond: RoundedRectangle(cornerRadius: 12)
        case .squiggle: Rectangle()
        case .oval: Capsule()
        }
    }
    
    var color: Color {
        switch card.color {
        case .red: Color.red
        case .green: Color.green
        case .purple: Color.purple
        }
    }
}

#Preview {
    CardView(ShapeSetGame().cards.first!)
}
