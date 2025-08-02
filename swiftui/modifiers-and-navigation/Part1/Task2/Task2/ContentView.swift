//
//  ContentView.swift
//  Task2
//
//  Created by Lukasz Fabia on 29/07/2025.
//

import SwiftUI

//Create a `Rectangle` view with a red color and use the `frame` modifier to set its width to 150 and height to 100. Center the view inside the parent container using the `alignment` parameter. Add a second `Rectangle` inside the parent container and align it to the top-right of the screen.

struct ContentView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.red)
                .frame(width: 150, height: 100)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            
            Rectangle()
                .foregroundStyle(.tint)
                .frame(width: 150, height: 100)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding()
        }
    }
}

#Preview {
    ContentView()
}
