//
//  ContentView.swift
//  Task3
//
//  Created by Lukasz Fabia on 29/07/2025.
//

import SwiftUI
//
//Create an `HStack` with three `Text` views that display "Item 1", "Item 2", and "Item 3". Use the `spacing` modifier on the HStack to set consistent spacing between the items. Add padding to the entire `HStack` and adjust the alignment of the text views within the stack.

struct ContentView: View {
    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 10) {
            Text("Item 1")
            Text("Item 2")
            Text("Item 3")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
