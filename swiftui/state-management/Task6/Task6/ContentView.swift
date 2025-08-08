//
//  ContentView.swift
//  Task6
//
//  Created by Lukasz Fabia on 08/08/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var settings: [Setting] = Setting.previewData
    
    var body: some View {
        Form {
            Section {
                List {
                    ForEach($settings) { $setting in
                        Toggle(setting.name , isOn: $setting.isEnabled)
                    }
                }
            } header: {
                Text("User preferences")
            }
        }
    }
}

#Preview {
    ContentView()
}
