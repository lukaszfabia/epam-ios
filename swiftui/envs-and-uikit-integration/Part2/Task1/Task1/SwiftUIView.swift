//
//  SwiftUIView.swift
//  Task1
//
//  Created by Lukasz Fabia on 14/08/2025.
//

import SwiftUI

struct SwiftUIView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.locale) private var lang
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("@Enviroment")
                    .font(.title)
                    .bold()
                
                Text("""
                    This property wrapper lets my view to get some predefined enviroment values:
                    """)
                
                Text("@Environment(\("\\").colorScheme) private var theme")
                    .font(.system(.body, design: .monospaced))
                
                Text("Use cases:")
                    .bold().font(.title2)
                
                
                Text("My region is \(lang.language.region?.identifier ?? "Unknown")")
                    .font(.body)
                
                Text("App lang is \(lang.language.languageCode?.identifier ?? "Unknown")")
                    .font(.body)
                
                
                Spacer()
                
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("SwiftUI Sheet")
            .toolbar {
                ToolbarItem {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }
}


#Preview {
    SwiftUIView()
}
