//
//  HomeView.swift
//  Task2
//
//  Created by Lukasz Fabia on 29/07/2025.
//

import SwiftUI

struct HomeView: View {
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack {
            Button(action: {path.append(NavPaths.settings)}, label: {Text("Go to Settings")})
        }
    }
}
