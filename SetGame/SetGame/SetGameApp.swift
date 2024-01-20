//
//  SetGameApp.swift
//  SetGame
//
//  Created by Eliott Radcliffe on 1/20/24.
//

import SwiftUI

@main
struct SetGameApp: App {
    @StateObject var game = ShapeSetGame()
    
    var body: some Scene {
        WindowGroup {
            ShapeSetGameView(viewModel: game)
        }
    }
}
