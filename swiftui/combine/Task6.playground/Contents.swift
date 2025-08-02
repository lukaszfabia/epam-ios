import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

//
//Create a PassthroughSubject that emits Int values, and use flatMap to convert these into publishers that emit the square of each number.

let publisher = PassthroughSubject<Int, Never>()

publisher.flatMap { e in
    Just(e*e)
}.sink { e in
    print(e)
}


for elem in 1...10 {
    publisher.send(elem)
}
