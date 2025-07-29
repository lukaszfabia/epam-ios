//
//  ContentView.swift
//  Task1
//
//  Created by Lukasz Fabia on 29/07/2025.
//

import SwiftUI

//Create a simple app that uses `NavigationStack` for navigating between two views:
//The first view should display a "Welcome" message and a button.
//Clicking the button should navigate to a second view that displays "Hello, SwiftUI Navigation!".
//Use a `NavigationLink` to set up the navigation.




struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Welcome")
                
                NavigationLink(destination: SecondaryView(), label: {Text("click")})
            }
            .padding()
        }
        .navigationTitle("Welcome")
    }
}

#Preview {
    ContentView()
}
