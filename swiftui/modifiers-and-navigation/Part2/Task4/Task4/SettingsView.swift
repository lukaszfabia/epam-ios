//
//  ContentView.swift
//  Task4
//
//  Created by Lukasz Fabia on 29/07/2025.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack{
            Image(systemName: "gear")
        }
        .toolbar(.hidden)// we re blocked
    }
}

#Preview {
    SettingsView()
}
