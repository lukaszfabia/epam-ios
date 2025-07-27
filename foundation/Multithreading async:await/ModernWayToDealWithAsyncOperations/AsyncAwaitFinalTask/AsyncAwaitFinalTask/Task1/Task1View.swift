//
//  SwiftUIView.swift
//  AsyncAwaitFinalTask
//
//  Created by Nikolay Dechko on 4/9/24.
//

import SwiftUI

struct Task1View: View {
    @State private var task1API = Task1API()
    @State private var fact = "To get random number fact presss button below"
    
    var body: some View {
        VStack {
            if task1API.isLoading {
                ProgressView()
            } else if let err = task1API.error {
                Text(err)
                    .padding()
                    .bold()
                    .font(.system(size: 20))
                    .foregroundStyle(.red)
                Button(action: {
                    Task {
                        self.fact = await task1API.getTrivia(for: .none) ?? "Something went wrong"
                    }
                }, label: { Text("Try again") })
            }
            else {
                Text(fact)
                    .padding()
                Button(action: {
                    Task {
                        if let randomFact = await task1API.getTrivia() {
                            self.fact = randomFact
                        }
                    }
                }, label: { Text("Click me") })
            }
        }
    }
}

#Preview {
    Task1View()
}

@MainActor
@Observable
class Task1API {
    private let baseURL = "http://numbersapi.com"
    private let triviaPath = "random/trivia"
    private var session = URLSession.shared
    
    var isLoading = false
    var error: String? = nil
    
    func getTrivia(for number: Int? = .none) async -> String? {
        error = nil
        isLoading = true
        defer {isLoading = false}
        
        guard let url = URL(string: baseURL)?.appendingPathComponent(triviaPath) else {
            error = "Failed to build url"
            return nil
        }
        
        do {
            let (data, response) = try await session.data(from: url)
                                                        
            guard let httpResponse = response as? HTTPURLResponse
            else {
                error = "Invalid HTTP response"
                return nil
            }
            
            guard (200..<300).contains(httpResponse.statusCode) else {
                error = "Invalid status code"
                return nil
            }
            
            guard let randomFact = String(data: data, encoding: .utf8) else {
                error = "Failed to decode fact"
                return nil
            }
            
            return randomFact
            
        } catch let err {
            print("Error: \(err.localizedDescription)")
            error = "Something went wrong"
            return nil
        }
    }
}
