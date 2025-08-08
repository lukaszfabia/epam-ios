//
//  ContentView.swift
//  Task7
//
//  Created by Lukasz Fabia on 08/08/2025.
//

import SwiftUI

struct RootView: View {
    @State private var shared: SharedObject = .init()
    
    var body: some View {
        TabView {
            Tab("First", systemImage: "house") {
                FirstView(shared: $shared)
            }

            Tab("Second", systemImage: "chart.bar") {
                SecondView(shared: $shared)
            }
        }
    }
}

#Preview {
    RootView()
}
