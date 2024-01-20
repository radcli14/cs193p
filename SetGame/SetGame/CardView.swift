//
//  CardView.swift
//  SetGame
//
//  Created by Eliott Radcliffe on 1/20/24.
//

import SwiftUI

struct CardView: View {
    let card: SetGame.Card
    
    var body: some View {
        Text(card.id)
    }
}

#Preview {
    CardView(
        card: SetGame.Card(
            condition1: .one,
            condition2: .two,
            condition3: .three,
            condition4: .one
        )
    )
}
