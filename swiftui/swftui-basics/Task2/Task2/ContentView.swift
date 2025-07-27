//
//  ContentView.swift
//  Task2
//
//  Created by Lukasz Fabia on 27/07/2025.
//

import SwiftUI

//Create a `List` of five names. Each row should include a `Text` view with the name and a `Button` labeled "Tap". When the button is pressed, print the name to the console.

struct ContentView: View {
    private let names: [String] = ["Lukasz", "Lukas", "Lucas", "Lucian", "Luciano"]
    
    var body: some View {
        VStack {
            List(names, id: \.self) { name in
                HStack(alignment: .firstTextBaseline) {
                    Text(name)
                    Button(action: {
                        print(name)
                    }, label: {Text("Tap")})
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
