//
//  Squiggle.swift
//  SetGame
//
//  Created by Eliott Radcliffe on 1/22/24.
//

import SwiftUI

struct Squiggle: Shape {
    func path(in rect: CGRect) -> Path {
        let oneQuarterX = rect.minX + Constants.xOffsetRatio * (rect.maxX - rect.minX)
        let threeQuarterX = rect.minX + (1 - Constants.xOffsetRatio) * (rect.maxX - rect.minX)
        let oneQuarterY = rect.minY + Constants.yOffsetRatio * (rect.maxY - rect.minY)
        let threeQuarterY = rect.minY + (1 - Constants.yOffsetRatio) * (rect.maxY - rect.minY)
        
        var p = Path()
        p.move(to: CGPoint(x: rect.minX, y: oneQuarterY))
        p.addCurve(
            to: CGPoint(x: rect.maxX, y: threeQuarterY) ,
            control1: CGPoint(x: oneQuarterX, y: rect.maxY),
            control2: CGPoint(x: threeQuarterX, y: rect.midY)
        )
        p.addCurve(
            to: CGPoint(x: rect.minX, y: oneQuarterY),
            control1: CGPoint(x: threeQuarterX, y: rect.minY),
            control2: CGPoint(x: oneQuarterX, y: rect.midY)
        )
        p.closeSubpath()
        return p
    }
    
    private struct Constants {
        static let xOffsetRatio = 0.35
        static let yOffsetRatio = 0.2
    }
}

#Preview {
    Squiggle().foregroundColor(.green)
}
