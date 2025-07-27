//
//  ContentView.swift
//  Task3
//
//  Created by Lukasz Fabia on 27/07/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack(spacing: 20) {
            ZStack {
                Circle().fill(.gray)
                    .frame(width: 105, height: 105)
                    .shadow(radius: 12)
                
                AsyncImage(url: URL(string: "https://i.pravatar.cc/300")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .shadow(radius: 12)
                    
                } placeholder: {
                    Image(systemName: "questionmark")
                }
            }
            
            
            VStack (alignment: .leading, spacing: 10) {
                Text("Name")
                Text("Subtitle")
            }
            
        }
        .padding()
        
    }
}

#Preview {
    ContentView()
}
