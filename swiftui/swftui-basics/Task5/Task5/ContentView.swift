//
//  ContentView.swift
//  Task5
//
//  Created by Lukasz Fabia on 27/07/2025.
//

import SwiftUI

struct CardView<Content: View>: View {
    let title: String
    
    @ViewBuilder var content: () -> Content

    
    var body: some View {
        VStack(spacing: 10) {
            Text(title)
            content()
            
            Button {
                
            } label: {
                Image(systemName: "arrow.right")
                    
            }

        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .shadow(radius: 10)
        .background(Color.gray.opacity(0.3))
        
    }
}

struct ContentView: View {
    @State private var input = ""
    
    var body: some View {
        VStack {
            CardView(title: "Lol") {
                HStack {
                    Text("lorem")
                        .foregroundStyle(.primary)
                    Text("impsum")
                        .foregroundStyle(.secondary)
                }
            }
            
            CardView(title: "TEEST") {
                VStack {
                    Text("Dont test me")
                }
            }
            
            CardView(title: "TEEST") {
                VStack {
                    Button {
                        //
                    } label: {
                        Image(systemName: "arrow.left")
                    }

                }
            }
        }
        .padding()
    }

}

#Preview {
    ContentView()
}
