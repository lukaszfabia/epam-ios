//
//  DecrementCounterView.swift
//  Task1
//
//  Created by Lukasz Fabia on 09/08/2025.
//

import SwiftUI

struct DecrementCounterView: View {
    @EnvironmentObject var counter: CounterViewModel
    
    var body: some View {
        NavigationStack {
            VStack{
                
                Button("Decrement") {
                    counter.counterValue -= 1
                }
                
            }.navigationTitle("Decrement")
        }
    }
}

#Preview {
    DecrementCounterView()
}
