//
//  DiamondShape.swift
//  SetGame
//
//  Created by Eliott Radcliffe on 1/22/24.
//

import SwiftUI

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: rect.minX, y: rect.midY)) // Left-Center
        p.addLine(to: CGPoint(x: rect.midX, y: rect.maxY)) // Center-Top
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.midY)) // Right-Center
        p.addLine(to: CGPoint(x: rect.midX, y: rect.minY)) // Center-Bottom
        p.closeSubpath() // Left-Center
        return p
    }
}

#Preview {
    Diamond().foregroundColor(.green)
}
