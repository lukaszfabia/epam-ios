//
//  ContentView.swift
//  Task4
//
//  Created by Lukasz Fabia on 29/07/2025.
//

import SwiftUI

struct SecondaryView: View {
    var body: some View {
        VStack {
            Text("Secondary view")
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Secondary")
        .toolbarBackground(Color.gray.opacity(0.2))
    }
}

#Preview {
    SecondaryView()
}
