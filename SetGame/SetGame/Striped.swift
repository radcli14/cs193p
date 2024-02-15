//
//  Striped.swift
//  SetGame
//
//  Created by Eliott Radcliffe on 2/15/24.
//

import SwiftUI

struct Striped: View {
    var body: some View {
        var xStart: CGFloat = 0
        var yStart: CGFloat = 0
        GeometryReader { geometry in
            let w = geometry.size.width
            let h = geometry.size.height
            Path { path in
                while yStart <= h || xStart <= w {
                    path.move(to: CGPoint(x: xStart, y: yStart))
                    path.addLine(to: CGPoint(
                        x: yStart - w >= 0 ? w : yStart + xStart,
                        y: yStart - w >= 0 ? yStart + xStart - w: 0
                    ))
                    xStart = yStart < h ? 0 : xStart + spacing
                    yStart = yStart < h ? yStart + spacing : yStart
                }
            }
            .stroke(lineWidth: lineWidth)
        }
    }
    
    private let spacing: CGFloat = 10
    private let lineWidth: CGFloat = 2
}

#Preview {
    Striped().foregroundColor(.green)
}
