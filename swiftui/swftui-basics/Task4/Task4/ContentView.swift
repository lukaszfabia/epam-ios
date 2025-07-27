//
//  ContentView.swift
//  Task4
//
//  Created by Lukasz Fabia on 27/07/2025.
//

import SwiftUI

//Create a custom `ToggleStyle` to make a switch that changes color when enabled. Use `Toggle` with this style to control the theme of a screen (e.g., dark/light mode background).


struct ThemeToggler: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            HStack {
                Image(systemName: configuration.isOn
                      ? "sun.max.fill"
                      : "moon.fill")
                configuration.label
            }
        }
        .tint(.primary)
        .buttonStyle(.borderless)
    }
}

struct ContentView: View {
    @State private var isDarkMode = false
    
    var body: some View {
        VStack {
            Toggle("", isOn: $isDarkMode)
                .toggleStyle(ThemeToggler())
                .padding()
        }.preferredColorScheme(isDarkMode ? .dark : .light)
    }
}


#Preview {
    ContentView()
}
