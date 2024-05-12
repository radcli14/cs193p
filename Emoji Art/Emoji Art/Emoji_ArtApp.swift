//
//  Emoji_ArtApp.swift
//  Emoji Art
//
//  Created by Eliott Radcliffe on 4/1/24.
//

import SwiftUI

@main
struct Emoji_ArtApp: App {
    @StateObject var defaultDocument = EmojiArtDocument()
    @StateObject var paletteStore = PaletteStore(named: "Main")
    @StateObject var store2 = PaletteStore(named: "Second Store")
    @StateObject var store3 = PaletteStore(named: "Third Store")
    
    var body: some Scene {
        WindowGroup {
            //PaletteManager(stores: [paletteStore, store2, store3])
            EmojiArtDocumentView(document: defaultDocument)
                .environmentObject(paletteStore)
        }
    }
}
