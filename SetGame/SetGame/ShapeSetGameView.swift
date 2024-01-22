//
//  ContentView.swift
//  SetGame
//
//  Created by Eliott Radcliffe on 1/20/24.
//

import SwiftUI

struct ShapeSetGameView: View {
    @ObservedObject var viewModel: ShapeSetGame
    
    var body: some View {
        VStack {
            Text("SET!").font(.largeTitle)
            AspectVGrid(
                Array(viewModel.cards[..<9]),
                aspectRatio: 2/3
            ) { card in
                CardView(card)
                    .padding(4)
            }
        }
        .padding()
    }
}

#Preview {
    ShapeSetGameView(viewModel: ShapeSetGame())
}
