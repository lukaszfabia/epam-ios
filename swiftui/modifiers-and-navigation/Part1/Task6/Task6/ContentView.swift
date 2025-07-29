//
//  ContentView.swift
//  Task6
//
//  Created by Lukasz Fabia on 29/07/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var tapped: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, \(tapped ? "Swift" : "World")")
                    .animation(.easeInOut(duration: 0.1))
            }
            
            PrimaryButton(text: "My button") {
                tapped.toggle()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
