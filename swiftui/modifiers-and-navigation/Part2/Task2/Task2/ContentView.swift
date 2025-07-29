//
//  ContentView.swift
//  Task2
//
//  Created by Lukasz Fabia on 29/07/2025.
//

import SwiftUI


struct ContentView: View {
    @State private var path: NavigationPath = .init()
    
    var body: some View {
        NavigationStack(path: $path) {
            Section("Links") {
                Button(action: {path.append(NavPaths.profile)}, label: {Text("Go to Profile")})
                Button(action: {path.append(NavPaths.settings)}, label: {Text("Go to Settings")})
                Button(action: {path.append(NavPaths.home)}, label: {Text("Go to Home")})
            }
            .navigationDestination(for: NavPaths.self) { path in
                switch path {
                case .home:
                    HomeView(path: $path)
                case .profile:
                    ProfileView(path: $path)
                case .settings:
                    SettingsView(path: $path)
                }
            }
            
        }
    }
}

#Preview {
    ContentView()
}
