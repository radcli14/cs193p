//
//  EmojiArtDocumentView.swift
//  Emoji Art
//
//  Created by Eliott Radcliffe on 4/1/24.
//

import SwiftUI

struct EmojiArtDocumentView: View {
    typealias Emoji = EmojiArt.Emoji
    
    @ObservedObject var document: EmojiArtDocument
    
    var body: some View {
        VStack {
            documentBody
            PaletteChooser()
                .font(.system(size: Constants.paletteEmojiSize))
                .padding(.horizontal)
                .scrollIndicators(.hidden)
        }
    }
    
    private var documentBody: some View {
        GeometryReader { geometry in
            ZStack {
                Color.white
                documentContents(in: geometry)
                    .scaleEffect(backgroundZoom * (document.zeroEmojisAreSelected ? gestureZoom : 1))
                    .offset(backGroundPan + (document.zeroEmojisAreSelected ? gesturePan : .zero))
            }
            .gesture(panGesture.simultaneously(with: zoomGesture).simultaneously(with: tapOnBackgroundGesture))
            .dropDestination(for: Sturldata.self) { sturldatas, location in
                return drop(sturldatas, at: location, in: geometry)
            }
        }
    }
    
    @ViewBuilder
    private func documentContents(in geometry: GeometryProxy) -> some View {
        AsyncImage(url: document.background)
            .position(Emoji.Position.zero.in(geometry))
        ForEach(document.emojis) { emoji in
            emojiView(for: emoji, in: geometry)
        }
    }
    
    private func emojiView(for emoji: Emoji, in geometry: GeometryProxy) -> some View {
        Text(emoji.string)
            .background {
                RoundedRectangle(cornerRadius: Constants.selectedEmojiCornerRadius)
                    .stroke(emoji.isSelected(in: document) ? Color.green : Color.clear,
                            lineWidth: Constants.selectedEmojiLineWidth)
            }
            .emojiContextMenu(onDeleteAction: { document.delete(emoji) })
            .font(emoji.font)
            .scaleEffect(emoji.isSelected(in: document) ? gestureZoom : 1)
            .position(positionDuringPan(for: emoji).in(geometry))
            .onTapGesture {
                withAnimation {
                    document.toggleEmojiSelection(of: emoji)
                }
            }
    }
    
    // MARK: - Gestures
    
    @State private var backgroundZoom: CGFloat = 1
    @State private var backGroundPan: CGOffset = .zero
    
    @GestureState private var gestureZoom: CGFloat = 1
    @GestureState private var gesturePan: CGOffset = .zero
    
    private var zoomGesture: some Gesture {
        MagnificationGesture()
            .updating($gestureZoom) { inMotionPinchScale, gestureZoom, _ in
                gestureZoom = inMotionPinchScale
            }
            .onEnded { endingPinchScale in
                backgroundZoom *= document.zeroEmojisAreSelected ? endingPinchScale : 1
                for id in document.selectedEmojis {
                    document.resize(emojiWithId: id, by: endingPinchScale)
                }
            }
    }
    
    private var panGesture: some Gesture {
        DragGesture()
            .updating($gesturePan) { inMotionDragGestureValue, gesturePan, _ in
                gesturePan = inMotionDragGestureValue.translation
            }
            .onEnded { endingDragGestureValue in
                backGroundPan += document.zeroEmojisAreSelected ? endingDragGestureValue.translation : .zero
                for id in document.selectedEmojis {
                    document.move(
                        emojiWithId: id,
                        by: endingDragGestureValue.translation,
                        multiplier: 1/backgroundZoom
                    )
                }
            }
    }
    
    private var tapOnBackgroundGesture: some Gesture {
        TapGesture()
            .onEnded {
                if document.someEmojisAreSelected {
                    withAnimation {
                        document.deselectAllEmojis()
                    }
                }
            }
    }
    
    private func drop(_ sturldatas: [Sturldata], at location: CGPoint, in geometry: GeometryProxy) -> Bool {
        for sturldata in sturldatas {
            switch sturldata {
            case .url(let url):
                print("url = \(url)")
                document.setBackground(url)
                return true
            case .string(let emoji):
                document.addEmoji(
                    emoji,
                    at: emojiPosition(at: location, in: geometry),
                    size: Constants.paletteEmojiSize / backgroundZoom
                )
                return true
            default:
                break
            }
        }
        return false
    }
    
    private func emojiPosition(at location: CGPoint, in geometry: GeometryProxy) -> Emoji.Position {
        let center = geometry.frame(in: .local).center
        return Emoji.Position(
            x: Int((location.x - center.x - backGroundPan.width) / backgroundZoom),
            y: Int(-(location.y - center.y - backGroundPan.height) / backgroundZoom)
        )
    }
    
    private func positionDuringPan(for emoji: Emoji) -> Emoji.Position {
        emoji.moved(
            by: emoji.isSelected(in: document) ? gesturePan : .zero,
            multiplier: 1/backgroundZoom
        )
    }
    
    // MARK: - Constants
    
    private struct Constants {
        static let paletteEmojiSize: CGFloat = 40
        static let selectedEmojiCornerRadius = CGFloat(12)
        static let selectedEmojiLineWidth = CGFloat(5)
    }
}

#Preview {
    EmojiArtDocumentView(document: EmojiArtDocument())
        .environmentObject(PaletteStore(named: "Preview"))
}
