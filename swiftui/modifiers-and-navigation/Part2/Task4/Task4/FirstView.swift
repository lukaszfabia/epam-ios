//
//  ContentView.swift
//  Task4
//
//  Created by Lukasz Fabia on 29/07/2025.
//

import SwiftUI

struct FirstView: View {
    var body: some View {
        NavigationStack{
            VStack {
                NavigationLink(destination: SecondaryView(), label: {
                    HStack{
                        Text("Next view")
                        Image(systemName: "arrow.right")
                    }
                })
            }
            .navigationTitle("First view")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem {
                    NavigationLink(destination: SettingsView(), label: {
                        Image(systemName: "gear")
                    })
                }
            }
            .toolbarBackgroundVisibility(.visible, for: .navigationBar)
            .toolbarBackground(.gray.opacity(0.2), for: .navigationBar)
        }
    }
}

#Preview {
    FirstView()
}
