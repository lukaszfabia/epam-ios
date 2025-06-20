//
//  User.swift
//  ProfilePage
//
//  Created by Lukasz Fabia on 19/06/2025.
//

struct User {
    let name: String
    let avatar: String
    let bio: String
    let followersCount: Int
    let followingCount: Int
    let posts: [Post]
    
    
    static func dummy() -> User {
        return User(name: "LukaszFabia", avatar: "jo", bio: "my bio", followersCount: 4, followingCount: 45, posts: [])
    }
}
