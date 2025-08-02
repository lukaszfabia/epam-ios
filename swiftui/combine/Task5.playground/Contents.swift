import Combine
import PlaygroundSupport
import Foundation

PlaygroundPage.current.needsIndefiniteExecution = true

let greeting = "Hello, playground"

//
//Simulate a text input field by publishing a sequence of strings (e.g., "H", "He", "Hel", "Hello"). Use the `debounce` operator to only emit the final value after a short delay.

let publisher = PassthroughSubject<String, Never>()

let sub = publisher
    .debounce(for: .seconds(2), scheduler: DispatchQueue.main)
    .sink { value in
        print(value)
    }


var buffer = ""
for elem in greeting {
    buffer.append(elem)
    sleep(1)
    publisher
        .send(buffer)
}
