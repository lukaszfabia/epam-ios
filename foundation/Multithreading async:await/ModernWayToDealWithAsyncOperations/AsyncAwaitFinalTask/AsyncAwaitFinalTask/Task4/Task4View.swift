//
//  Task4View.swift
//  AsyncAwaitFinalTask
//
//  Created by Nikolay Dechko on 08/07/2024.
//
import SwiftUI

struct Task4View: View {
    @State private var api = Task4ViewModelAPI()
    
    var body: some View {
        VStack {
            Text("Starting balance: 1000")
            if api.isLoading {
                VStack {
                    Text("Decrementing...")
                    ProgressView()
                }
            }
            else if api.finished {
                Text("Final balance: \(api.balance)")
                Text(api.balance == 0 ? "Success" : "Failure")
            }
            Button {
                if api.finished {
                    Task {
                        await api.reset()
                    }
                } else {
                    Task {
                        await api.startUpdate()
                    }
                }
            } label: {
                if api.finished {
                    Text("Reset")
                } else {
                    Text("Start")
                }
            }
        }
    }
}

#Preview {
    Task4View()
}

@MainActor
@Observable
class Task4ViewModelAPI {
    
    var isLoading: Bool = false
    var finished: Bool = false
    var balance: Int = 1000
    
    private var balancer: Balancer = .init()
    
    func startUpdate() async -> Int {
        isLoading = true
        defer {
            isLoading = false
            finished = true
        }
        
        await withTaskGroup(of: Void.self) { group in
            for _ in 0...999 {
                group.addTask {
                    await self.balancer.decrement()
                }
            }
        }
        
        balance = await balancer.balance
        
        return balance
    }
    
    func reset() async {
        await balancer.reset()
        balance = await balancer.balance
        finished = false
        isLoading = false
    }
}


actor Balancer {
    private(set) var balance: Int = 1000
    
    func decrement() async {
        balance -= 1
    }
    
    func reset() async {
        balance = 1000
    }
}
