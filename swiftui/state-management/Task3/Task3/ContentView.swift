//
//  ContentView.swift
//  Task3
//
//  Created by Lukasz Fabia on 29/07/2025.
//

import SwiftUI

enum MyActor: String {
    case child, parent
}

struct ContentView: View {
    @State private var whoUpdated: MyActor = .parent
    @State private var conditional: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Who previously updated the state: \(whoUpdated)")
                Text("Current state: \(conditional)")
                
                NavigationLink(destination: ChildView(conditional: $conditional, whoUpdated: $whoUpdated)) {
                    Text("Child View")

                }
            }
            .padding()
            .navigationTitle("Root View")
            .navigationBarTitleDisplayMode(.large)
            .toolbar{
                ToolbarItem {
                    Button {
                        conditional.toggle()
                        whoUpdated = .parent
                    } label: {
                        Text("Update")
                    }

                }
            }
        }
    }
}

#Preview {
    ContentView()
}
