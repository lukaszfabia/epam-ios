//
//  Config.swift
//  Task3
//
//  Created by Lukasz Fabia on 23/07/2025.
//

import Foundation
import UIKit

struct Config: Codable {
    let galleryTitle: String
    let images: [Image]
    
    let grid: Grid
    
    let prefferedTheme: Theme
    let errorIconName: String

    static func `default`() -> Config {
        return Config(
            galleryTitle: "Images",
            images: [],
            grid: Grid.default(),
            prefferedTheme: .system,
            errorIconName: "questionmark",
        )
    }
}
