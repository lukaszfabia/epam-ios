import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true


let passObject = PassthroughSubject<Int, Never>()

let sub = passObject.filter { number in
    return number % 2 == 0
}.sink { number in
    print("Received next event number: \(number)")
}

for number in 1..<20 {
    passObject.send(number)
}

//sub.cancel()
//
//for number in 23..<555 {
//    passObject.send(number)
//}

