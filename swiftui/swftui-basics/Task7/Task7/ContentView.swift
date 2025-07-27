//
//  ContentView.swift
//  Task7
//
//  Created by Lukasz Fabia on 27/07/2025.
//

import SwiftUI

struct RandomAvatar: View {
    let isPremium: Bool

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            AsyncImage(url: URL(string: "https://avatar.iran.liara.run/public")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
            } placeholder: {
                ProgressView()
                    .frame(width: 100, height: 100)
            }

            if isPremium {
                Image(systemName: "checkmark.seal.fill")
                    .foregroundStyle(.blue)
                    .clipShape(Circle())
                    .font(.system(size: 24))
                    .offset(x: 5, y: 5)
            }
        }
        .frame(width: 105, height: 105)
    }
}


struct User: Identifiable {
    let id = UUID()
    let name: String
    let age: Int
    
    let location: String
    
    let isPremium: Bool
}

struct ProfileInfo: View {
    let name: String
    let age: Int
    
    let location: String
    
    var body: some View {
        VStack {
            HStack {
                Text(name)
                    .bold()
                    .foregroundStyle(.primary)
                    .font(.title)
                
                Text("\(age) yo")
                    .fontWeight(.light)
                    .foregroundStyle(.secondary)
                    .font(.title3)
                    .padding(.top, 5)
            }
            
            HStack(spacing: 5) {
                Image(systemName: "location")
                Text(location)
                    .font(.footnote)
            }
        }
    }
    
}

struct ProfileCard: View {
    var user: User
    
    var body: some View {
        HStack(spacing: 20) {
            RandomAvatar(isPremium: user.isPremium)
            
            ProfileInfo(name: user.name, age: user.age, location: user.location)
            
            Spacer()
        }
        .padding()
        .shadow(radius: 10)
        .background(.gray.opacity(0.2))
    }
}


struct ContentView: View {
    let user: User = .init(name: "Lukasz", age: 21, location: "Wroclaw, lower siesia", isPremium: true)
    
    var body: some View {
        VStack {
            ForEach([user]) { user in
                ProfileCard(user: user)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
