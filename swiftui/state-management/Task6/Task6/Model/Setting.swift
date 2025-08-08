//
//  Setting.swift
//  Task6
//
//  Created by Lukasz Fabia on 08/08/2025.
//

import Foundation

struct Setting: Identifiable {
    let id = UUID()
    
    let name: String
    var isEnabled: Bool = false
    
    static let previewData: [Setting] = [
        .init(name: "Dark mode"),
        .init(name: "NSFW content"),
        .init(name: "Notifications"),
    ]
}
