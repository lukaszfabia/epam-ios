//
//  ContentView.swift
//  Task4
//
//  Created by Lukasz Fabia on 29/07/2025.
//

import SwiftUI
//
//Create a `Circle` view with a size of 100 points and a blue color. Use the `offset` modifier to position the circle slightly outside the top-left corner of the screen. Add another shape, such as a `Rectangle`, below the circle and experiment with different offsets for both.

struct ContentView: View {
    var body: some View {
        VStack {
            Circle()
                .frame(width: 100, height: 100)
                .foregroundStyle(.blue)
                .shadow(radius: 5)
                .offset(x: -160, y: -330) // slightly outside
            
            Rectangle()
                .frame(width: 100, height: 100)
                .foregroundStyle(.red)
                .shadow(radius: 5)
                .offset(x: -160, y: 200) // slightly outside
            
//            Rectangle()
//                .frame(width: 100, height: 100)
//                .foregroundStyle(.green)
//                .shadow(radius: 5)
//                .offset(x: -5, y: -10) // slightly outside
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
