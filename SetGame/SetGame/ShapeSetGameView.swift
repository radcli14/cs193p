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
            CardView(viewModel.cards.first!)
        }
        .padding()
    }
}

#Preview {
    ShapeSetGameView(viewModel: ShapeSetGame())
}
