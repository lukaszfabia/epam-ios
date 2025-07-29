//
//  ContentView.swift
//  Task5
//
//  Created by Lukasz Fabia on 29/07/2025.
//

import SwiftUI

//Create a `Text` view that displays "SwiftUI is amazing!". Add a `background` modifier that applies a gray rectangle behind the text. Then add an overlay modifier to place a semi-transparent `Circle` over the text. Then, using the `clipShape` modifier, remake your view this way, that text would be inside the circle, revealing only the "center" part of initial string.

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "sparkles")
                .imageScale(.large)
                .foregroundStyle(.yellow)
                .padding(4)
            
            Text("SwiftUI is amazing!")
                .padding()
                .background(.gray.opacity(0.2))
                .overlay(content: {
                    Circle().fill(.orange).opacity(0.1)
                })
                .clipShape(Circle())
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
