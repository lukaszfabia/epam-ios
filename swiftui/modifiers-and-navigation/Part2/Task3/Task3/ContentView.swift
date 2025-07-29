//
//  ContentView.swift
//  Task3
//
//  Created by Lukasz Fabia on 29/07/2025.
//

import SwiftUI

struct ContentView: View {
    let fruits = Fruit.dummies()
    
    var body: some View {
        NavigationStack {
            VStack {
                List(fruits) { fruit in
                    NavigationLink(destination: FruitShowcaseView(fruit: fruit), label: {
                        Text(fruit.name)
                    })
                }
            }
            .padding()
        }
        .navigationTitle("Groceries")
        
    }
}

#Preview {
    ContentView()
}
