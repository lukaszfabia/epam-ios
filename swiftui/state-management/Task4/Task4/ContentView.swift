//
//  ContentView.swift
//  Task4
//
//  Created by Lukasz Fabia on 08/08/2025.
//

import SwiftUI

@Observable
class User {
    var email: String = ""
    var name: String = ""
    
    func clear() {
        email = ""
        name = ""
    }
}

struct ContentView: View {
    @State private var user: User = .init()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Your name...", text: $user.name)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                } header: {
                    Text("Name")
                }
                
                Section {
                    TextField("Your email...", text: $user.email)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                } header: {
                    Text("Contact information")
                }
                
                Section {
                    VStack(alignment: .leading) {
                        
                        Text("Name: \(user.name)")
                            .font(.callout)
                            .padding(2)
                        
                        Text("Email: \(user.email)")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .padding(2)
                        
                    }
                } header: {
                    Text("Information")
                }
                
            }
            .padding()
            .navigationTitle("User form")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button {
                        user.clear()
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
