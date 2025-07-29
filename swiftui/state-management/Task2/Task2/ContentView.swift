//
//  ContentView.swift
//  Task2
//
//  Created by Lukasz Fabia on 29/07/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var isOn: Bool = false
    
    var body: some View {
        VStack {
            Toggle(isOn: $isOn) {
                Text("Click me")
            }
            
            if isOn {
                Text("Hello, SwiftUI!")
            }
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 10)
    }
}

#Preview {
    ContentView()
}
