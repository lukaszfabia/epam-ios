//
//  ContentView.swift
//  Task7
//
//  Created by Lukasz Fabia on 02/08/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var vm = ContentViewModel()
    
    var body: some View {
        VStack(spacing: 40) {
            Button {
                vm.publishNewValue()
            } label: {
                Text("Click me")
                    .font(.title)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
