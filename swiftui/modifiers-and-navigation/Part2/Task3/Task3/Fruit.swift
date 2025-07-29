//
//  Fruit.swift
//  Task3
//
//  Created by Lukasz Fabia on 29/07/2025.
//

import Foundation

struct Fruit: Identifiable, Hashable {
    let id = UUID()
    
    let name: String
    
    let weightInGrams: Double

    let quantity: Double
    
    let imageUrl: URL
    
    let description: String
    
    static func == (_ lhs: Fruit, _ rhs: Fruit) -> Bool {
        return lhs.name == rhs.name
    }
    
    static func dummies() -> [Fruit] {
        return [
            .init(name: "Banana", weightInGrams: 50, quantity: 3312, imageUrl: URL(string: "https://images.unsplash.com/photo-1528825871115-3581a5387919?q=80&w=830&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")!, description: "Bananas are elongated, curved fruits that grow in clusters on the banana plant, a large herbaceous flowering plant in the genus Musa. They are typically yellow when ripe, but can also be green, red, or purple depending on the variety. The flesh of a banana is soft, sweet, and starchy, and is usually consumed after peeling away the outer skin"),
            .init(name: "Mango", weightInGrams: 140, quantity: 2311, imageUrl: URL(string: "https://plus.unsplash.com/premium_photo-1724255863045-2ad716767715?q=80&w=774&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")!, description: "A mango is a fleshy, oval or egg-shaped fruit, a drupe, that can vary in size, shape, color, and taste depending on the cultivar. Typically, mangos are 8–12 centimeters (3–5 inches) long and have a greenish-yellow skin when unripe, turning orange-reddish as they ripen. The interior flesh is usually bright orange and soft, with a large, flat pit in the center"),
            .init(name: "Watermelon", weightInGrams: 300, quantity: 1241, imageUrl: URL(string: "https://images.unsplash.com/photo-1587049352846-4a222e784d38?q=80&w=1160&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")!, description: "Watermelon is a large, oblong or roundish fruit with a hard green or white rind and sweet, watery pink, yellowish, or red flesh, often containing many seeds. It is a widely cultivated vine of the gourd family according to Merriam-Webster. Watermelons are known for their refreshing, juicy flesh and are a popular choice for summer")
        ]
    }
}
