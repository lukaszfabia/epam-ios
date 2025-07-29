//
//  ChildView.swift
//  Task3
//
//  Created by Lukasz Fabia on 29/07/2025.
//

import SwiftUI

struct ChildView: View {
    @Binding var conditional: Bool
    @Binding var whoUpdated: MyActor
    
    var body: some View {
        VStack {
            Text("Who previously updated the state: \(whoUpdated)")
            Text("Current state: \(conditional)")
        }.padding()
            .navigationTitle("Child View")
            .navigationBarTitleDisplayMode(.large)
            .toolbar{
                ToolbarItem {
                    Button {
                        conditional.toggle()
                        whoUpdated = .child
                    } label: {
                        Text("Update")
                    }

                }
            }
    }
}
