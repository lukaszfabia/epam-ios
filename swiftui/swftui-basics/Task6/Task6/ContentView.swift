//
//  ContentView.swift
//  Task6
//
//  Created by Lukasz Fabia on 27/07/2025.
//

import SwiftUI
//
//Create a `List` of items (e.g., groceries or tasks), each with a name and a toggle switch. Store the data in an array of structs. Use @State to keep track of which items are enabled.

struct Task: Identifiable {
    let id = UUID()
    let name: String
    var isEnabled: Bool = false
    
    mutating func toggleEnabled() {
        isEnabled.toggle()
    }
}

struct CheckMarkToggler: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            HStack {
                Image(systemName: configuration.isOn
                      ? "checkmark.circle"
                      : "circle")
                configuration.label
            }
        }
        .tint(.primary)
        .buttonStyle(.borderless)
    }
}

struct ContentView: View {
    @State private var tasks: [Task] = [
        .init(name: "Make this task"),
        .init(name: "Get life"),
        .init(name: "Play with the cat"),
        .init(name: "Go on a walk"),
    ]
    
    var body: some View {
        VStack {
            List {
                ForEach($tasks) { $task in
                    Toggle(task.name, isOn: $task.isEnabled)
                        .toggleStyle(CheckMarkToggler())
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
