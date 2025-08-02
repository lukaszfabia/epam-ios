import Combine
import PlaygroundSupport
import Foundation

PlaygroundPage.current.needsIndefiniteExecution = true

let futurePublisher = Future<String, Never> { promise in
    promise(.success("Hello combine"))
}


let subscriber = futurePublisher
    .delay(for: .seconds(2), scheduler: DispatchQueue.main)
    .sink { state in
        print("State: \(state)")
    } receiveValue: { value in
        print(value)
    }

