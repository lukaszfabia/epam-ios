//
//  Task2View.swift
//  AsyncAwaitFinalTask
//
//  Created by Nikolay Dechko on 4/9/24.
//

import SwiftUI

private enum MyResult {
    case user(Task2API.User)
    case products([Task2API.Product])
}

struct Task2View: View {
    @State private var viewModel = Task2ViewModel()
    
    var body: some View {
        VStack {
            if let user = viewModel.user, !viewModel.products.isEmpty, let duration = viewModel.duration {
                Text("User name: \(user.name)").padding()
                List(viewModel.products) { product in
                    Text("product description: \(product.description)")
                }
                Text("it took: \(duration) second(s)")
            } else if viewModel.isLoading {
                VStack {
                    Text("Loading in progress")
                    ProgressView()
                }
            } else {
                Text(viewModel.error ?? "Something went wrong")
                    .foregroundStyle(.red)
            }
        }
        .task {
            await viewModel.fetch()
        }
    }
}


@MainActor
@Observable
class Task2ViewModel {
    
    var error: String? = nil
    var isLoading: Bool = false
    
    var user: Task2API.User? = nil
    var products: [Task2API.Product] = []
    
    var duration: TimeInterval? = nil
    
    private var api: Task2API = .init()
    
    func fetch() async {
        isLoading = true
        defer {isLoading = false}
        
        error = nil
        
        do {
            let start = Date.now
            
            try await withThrowingTaskGroup(of: MyResult.self) { group in
                group.addTask {
                    let user = try await self.api.getUser()
                    return .user(user)
                }
                
                group.addTask {
                    let products = try await self.api.getProducts()
                    
                    return .products(products)
                }
                
                for try await elem in group {
                    switch elem {
                    case .products(let products):
                        self.products = products
                    case .user(let user):
                        self.user = user
                    }
                }
            }
        
            let end = Date.now
            
            duration = DateInterval(start: start, end: end).duration
            
        } catch let err {
            error = "unexpected error: \(err.localizedDescription)"
        }
    }
    
}

actor Task2API {
    
    struct User {
        let name: String
    }

    struct Product: Identifiable {
        let id: String
        let description: String
    }
    
    func getUser() async throws -> User {
        try await Task.sleep(for: .seconds(1))
        return .init(name: "John Smith")
    }
    
    func getProducts() async throws -> [Product] {
        try await Task.sleep(for: .seconds(1))
        return [
            .init(id: "1", description: "Some cool product"),
            .init(id: "2", description: "Some expensive product")
        ]
    }
}

#Preview {
    Task2View()
}
