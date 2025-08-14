//
//  IncrementCounterView.swift
//  Task1
//
//  Created by Lukasz Fabia on 09/08/2025.
//

import SwiftUI

struct IncrementCounterView: View {
    @EnvironmentObject var counter: CounterViewModel
    
    var body: some View {
        NavigationStack {
            VStack{
                
                Button("Increment") {
                    self.counter.counterValue += 1
                }
                
            }.navigationTitle("Increment")
        }
    }
}

#Preview {
    IncrementCounterView()
}
