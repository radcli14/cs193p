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
                if document.background.isFetching {
                    ProgressView()
                        .scaleEffect(2)
                        .tint(.blue)
                        .position(Emoji.Position.zero.in(geometry))
                }
                documentContents(in: geometry)
                    .scaleEffect(backgroundZoom * (document.zeroEmojisAreSelected ? gestureZoom : 1))
                    .offset(backgroundPan + (documentShouldPan ? gesturePan.pan : .zero))
            }
            .gesture(panGesture.simultaneously(with: zoomGesture).simultaneously(with: tapOnBackgroundGesture))
            .onTapGesture(count: 2) {
                zoomToFit(document.bbox, in: geometry)
            }
            .dropDestination(for: Sturldata.self) { sturldatas, location in
                return drop(sturldatas, at: location, in: geometry)
            }
            .onChange(of: document.background.failureReason) {
                showBackgroundFailureAlert = document.background.failureReason != nil
            }
            .onChange(of: document.background.uiImage) {
                zoomToFit(document.background.uiImage?.size, in: geometry)
            }
            .alert(
                "Set Background",
                isPresented: $showBackgroundFailureAlert,
                presenting: document.background.failureReason,
                actions: { reason in
                    Button("OK", role: .cancel) { }
                },
                message: { reason in
                    Text(reason)
                }
            )
        }
    }
    
    private func zoomToFit(_ size: CGSize?, in geometry: GeometryProxy) {
        if let size {
            zoomToFit(CGRect(center: .zero, size: size), in: geometry)
        }
    }
    
    private func zoomToFit(_ rect: CGRect, in geometry: GeometryProxy) {
        withAnimation {
            if rect.size.width > 0, rect.size.height > 0, geometry.size.width > 0, geometry.size.height > 0 {
                let hZoom = geometry.size.width / rect.size.width
                let vZoom = geometry.size.height / rect.size.height
                backgroundZoom = min(hZoom, vZoom)
                backgroundPan = CGOffset(width: -rect.midX * backgroundZoom, height: -rect.midY * backgroundZoom)
            }
        }
    }
    
    @State private var showBackgroundFailureAlert = false
    
    @ViewBuilder
    private func documentContents(in geometry: GeometryProxy) -> some View {
        if let uiImage = document.background.uiImage {
            Image(uiImage: uiImage)
                .position(Emoji.Position.zero.in(geometry))
        }
            
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
            .gesture(tapOnEmojiGesture(emoji).simultaneously(with: dragSingleEmojiGesture(emoji.id)))
    }
    
    // MARK: - Gestures
    
    @State private var backgroundZoom: CGFloat = 1
    @State private var backgroundPan: CGOffset = .zero
    
    @GestureState private var gestureZoom: CGFloat = 1
    @GestureState private var gesturePan: GesturePanState = GesturePanState()

    private struct GesturePanState {
        var emojiId: Emoji.ID? = nil
        var pan: CGOffset = .zero
    }
    
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
                gesturePan = GesturePanState(pan: inMotionDragGestureValue.translation)
            }
            .onEnded { endingDragGestureValue in
                backgroundPan += document.zeroEmojisAreSelected ? endingDragGestureValue.translation : .zero
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
    
    private func tapOnEmojiGesture(_ emoji: Emoji) -> some Gesture {
        TapGesture().onEnded {
            withAnimation {
                document.toggleEmojiSelection(of: emoji)
            }
        }
    }
    
    private func dragSingleEmojiGesture(_ emojiId: Emoji.ID) -> some Gesture {
        DragGesture()
            .updating($gesturePan) { inMotionDragGestureValue, gesturePan, _ in
                gesturePan = GesturePanState(emojiId: emojiId, pan: inMotionDragGestureValue.translation)
            }
            .onEnded { endingDragGestureValue in
                document.move(
                    emojiWithId: emojiId,
                    by: endingDragGestureValue.translation,
                    multiplier: 1/backgroundZoom
                )
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
            x: Int((location.x - center.x - backgroundPan.width) / backgroundZoom),
            y: Int(-(location.y - center.y - backgroundPan.height) / backgroundZoom)
        )
    }
    
    private func positionDuringPan(for emoji: Emoji) -> Emoji.Position {
        emoji.moved(
            by: emojiShouldPan(emoji) ? gesturePan.pan : .zero,
            multiplier: 1/backgroundZoom
        )
    }
    
    private var documentShouldPan: Bool {
        document.zeroEmojisAreSelected && gesturePan.emojiId == nil
    }
    
    private func emojiShouldPan(_ emoji: Emoji) -> Bool {
        (emoji.isSelected(in: document) && gesturePan.emojiId == nil) || gesturePan.emojiId == emoji.id
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
