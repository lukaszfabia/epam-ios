//
//  ContentView.swift
//  Task1
//
//  Created by Lukasz Fabia on 29/07/2025.
//

import SwiftUI
//
//Create a SwiftUI view with a counter displayed using `Text` and a `Button` labeled “+1”. Tapping the button should increment the counter using a `@State` property.

struct ContentView: View {
    @State private var counter: Int = 0
    
    var body: some View {
        VStack {
            Text("Current value: \(counter)")
                .animation(.easeIn(duration:0.1), value: counter)
            
            Button(
                action: {counter+=1},
                label: {
                    Text("+1")
                }
            )
                
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
