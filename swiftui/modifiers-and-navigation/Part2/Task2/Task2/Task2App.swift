//
//  Task2App.swift
//  Task2
//
//  Created by Lukasz Fabia on 29/07/2025.
//

import SwiftUI


enum NavPaths: Hashable {
    case profile, settings, home
}

@main
struct Task2App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
