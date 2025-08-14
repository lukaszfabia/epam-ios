//
//  RootView.swift
//  Task1
//
//  Created by Lukasz Fabia on 09/08/2025.
//

import SwiftUI

struct RootView: View {
    @State var counter = CounterViewModel()
    
    var body: some View {
        TabView {
            Tab("Display", systemImage: "number") {
                CounterDisplayView().environmentObject(counter)
            }

            Tab("Increment", systemImage: "plus") {
                IncrementCounterView().environmentObject(counter)
            }

            Tab("Decrement", systemImage: "minus") {
                DecrementCounterView().environmentObject(counter)
            }
        }
    }
}

#Preview {
    RootView()
}
