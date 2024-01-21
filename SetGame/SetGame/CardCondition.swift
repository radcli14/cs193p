//
//  CardCondition.swift
//  SetGame
//
//  Created by Eliott Radcliffe on 1/21/24.
//

import Foundation

enum NumberOfShapes: CaseIterable {
    case one
    case two
    case three
}

enum TypeOfShape: CaseIterable {
    case diamond
    case squiggle
    case oval
}

enum Shading: CaseIterable {
    case solid
    case striped
    case open
}

enum ShapeColor: CaseIterable {
    case red
    case green
    case purple
}
