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
        .padding()
    }
    
    private struct Constants {
        static let aspectRatio: CGFloat = 2/3
        static let paddingAroundCards: CGFloat = 4
    }
}

#Preview {
    ShapeSetGameView(viewModel: ShapeSetGame())
}
