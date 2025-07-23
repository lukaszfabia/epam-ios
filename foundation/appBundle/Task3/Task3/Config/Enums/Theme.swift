//
//  Theme.swift
//  Task3
//
//  Created by Lukasz Fabia on 23/07/2025.
//

import UIKit

enum Theme: String, Codable {
    case system, dark, light
}

extension Theme {
    var style: UIUserInterfaceStyle {
        switch self {
        case .dark: return .dark
        case .light: return .light
        case .system: return UITraitCollection.current.userInterfaceStyle
        }
    }
}
