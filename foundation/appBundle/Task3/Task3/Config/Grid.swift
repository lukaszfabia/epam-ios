//
//  Grid.swift
//  Task3
//
//  Created by Lukasz Fabia on 23/07/2025.
//

struct Grid: Codable {
    let scrollingDirection: ScrollingDirection
    let spacing: Double
    let padding: Double
    let cols: Int?
    
    // MARK: static consts

    static func `default`() -> Grid {
        return Grid(scrollingDirection: .vertical, spacing: Grid.defaultSpacing, padding: Grid.defaultPadding, cols: Grid.defaultCols)
    }
    
    static let defaultCols = 1
    static let defaultSpacing = 7.0
    static let defaultPadding = 5.0
}
