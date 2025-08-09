//
//  SecondView.swift
//  Task7
//
//  Created by Lukasz Fabia on 08/08/2025.
//

import SwiftUI

struct SecondView: View {
    @Bindable var shared: SharedObject
    
    var body: some View {
        NavigationStack {
            VStack {
       
                Text("Current value: \(shared.counter)")
                    .padding()
                
                Button {
                    shared.increment()
                } label: {
                    Image(systemName: "plus")
                }
            }
            .padding()
            .navigationTitle("Second")
        }
    }
}
