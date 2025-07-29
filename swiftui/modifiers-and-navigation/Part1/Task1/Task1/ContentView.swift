//
//  ContentView.swift
//  Task1
//
//  Created by Lukasz Fabia on 29/07/2025.
//

import SwiftUI
//
//Create a simple `Text` view that displays the string "SwiftUI Layout Modifiers". Use the padding modifier to add 16 points of padding on all sides. Then experiment by applying padding only to specific edges. Add a background modifier to give the text a colorful background.

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "cross")
                .imageScale(.large)
                .foregroundStyle(.red)
            
            Text("SwiftUI Layout Modifiers")
                .padding(16)
            
            Text("Really helpful padding option")
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
            
            Text("Top padding")
                .padding(.top, 11)
            
            Text("Or right (trailing)")
                .padding(.trailing, 50)
            
            Text("Text with background")
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .foregroundStyle(.white)
                .background(Color.indigo)
                .cornerRadius(20)
        }
        .padding()
        .background(Color.gray.opacity(0.1)) // backgroud for container
        .cornerRadius(10)
    }
}

#Preview {
    ContentView()
}
