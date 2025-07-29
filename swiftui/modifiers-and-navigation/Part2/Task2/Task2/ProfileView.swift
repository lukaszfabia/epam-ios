//  ProfileView.swift
//  Task2
//
//  Created by Lukasz Fabia on 29/07/2025.
//

import SwiftUI

struct ProfileView: View {
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack {
            Button(action: {path.append(NavPaths.home)}, label: {Text("Go to Home")})
        }
    }
}
