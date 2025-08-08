//
//  EditProfileView.swift
//  Task5
//
//  Created by Lukasz Fabia on 08/08/2025.
//

import SwiftUI

struct EditProfileView: View {
    @State private var formModel: FormModel = .init()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField(text: $formModel.user.name, label: {Text("Username")})
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                    
                    TextField(text: $formModel.user.email, label: {Text("Email")})
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .keyboardType(.emailAddress)
                }
                
                header: {
                    Text("Information")
                }
            }.toolbar {
                ToolbarItem{
                    Button {
                        
                    } label: {
                        Text("Update")
                    }
                    .disabled(formModel.isUserInvalid)
                }
            }
        }
    }
}

#Preview {
    EditProfileView()
}
