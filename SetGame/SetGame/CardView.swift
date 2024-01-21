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
        VStack {
            Text(String(describing: card.number))
            Text(String(describing: card.typeOfShape))
            Text(String(describing: card.shading))
            Text(String(describing: card.color))
        }
        .padding(12)
        .background {
            RoundedRectangle(cornerRadius: 12).foregroundColor(.pink)
        }
    }
}

#Preview {
    CardView(ShapeSetGame().cards.first!)
}
