//
//  Cardify.swift
//  SetGame
//
//  Created by Eliott Radcliffe on 1/22/24.
//

import SwiftUI

struct Cardify: ViewModifier {
    let n: Int
    var isFaceUp: Bool
    var isSelected: Bool

    func body(content: Content) -> some View {
        GeometryReader { geometry in
            ZStack {
                let base = RoundedRectangle(
                    cornerRadius: Constants.roundingRatio * geometry.size.width
                )
                base.strokeBorder(lineWidth: Constants.lineWidthRatio * geometry.size.width)
                    .background(base.fill(.white))
                    .shadow(color: .accentColor, radius: isSelected ? Constants.shadowRadiusRatio * geometry.size.width : 0)
                    .overlay {
                        VStack(spacing: Constants.spacingRatio * geometry.size.width) {
                            ForEach(0..<n, id: \.self) { _ in
                                content
                            }
                        }
                        .padding(Constants.paddingRatio * geometry.size.width)
                    }
                    .opacity(isFaceUp ? 1 : 0)
                base.fill()
                    .opacity(isFaceUp ? 0 : 1)
            }
        }
    }
    
    
    
    private struct Constants {
        static let lineWidthRatio: CGFloat = 0.01
        static let aspectRatio: CGFloat = 2
        static let roundingRatio = 0.175
        static let paddingRatio = 0.1
        static let spacingRatio = 0.1
        static let shadowRadiusRatio: CGFloat = 0.05
    }
}

extension View {
    func cardify(n: Int, isFaceUp: Bool, isSelected: Bool) -> some View {
        modifier(Cardify(n: n, isFaceUp: isFaceUp, isSelected: isSelected))
    }
}
