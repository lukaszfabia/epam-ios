//
//  ContentView.swift
//  Task1
//
//  Created by Lukasz Fabia on 27/07/2025.
//

import SwiftUI

//Create a `VStack` containing a `Toggle` labeled “Show Greeting” and a `Text` view with the message “Hello, SwiftUI!”. The `Text` should appear only when the toggle is ON. Use `@State` for the toggle’s binding.
//



struct ContentView: View {
    @State private var isOn = false
    
    
    var body: some View {
        VStack(alignment: .center) {
            Toggle(isOn: $isOn, label: {Text("Show Greeting")})
                .padding(10)
                
            
            if isOn {
                Text("Hello SwiftUI!")
            }
        }
        .padding(20)
    }
}

#Preview {
    ContentView()
}
