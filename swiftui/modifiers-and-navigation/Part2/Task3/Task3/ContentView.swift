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
            List(fruits) { fruit in
                NavigationLink(value: fruit) {
                    Text(fruit.name)
                }
            }
            .navigationDestination(for: Fruit.self, destination: { fruit in
                FruitShowcaseView(fruit: fruit)
            })
            .navigationTitle("Groceries")
        }
        
    }				
}

#Preview {
    ContentView()
}
