//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Eliott Radcliffe on 1/10/24.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var store = EmojiThemeStore()
    
    var body: some Scene {
        WindowGroup {
            EmojiThemeChooser(viewModel: store)
        }
    }
}
