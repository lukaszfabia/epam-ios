//
//  CounterDisplayView.swift
//  Task1
//
//  Created by Lukasz Fabia on 09/08/2025.
//

import SwiftUI

struct CounterDisplayView: View {
    @EnvironmentObject var counter: CounterViewModel
    
    var body: some View {
        NavigationStack {
            VStack{
                
                Text("Current value: \(counter.counterValue)")
                
            }.navigationTitle("Current")
        }
    }
}

#Preview {
    CounterDisplayView()
}
