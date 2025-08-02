import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let simpleJustPublisher = Just("Hello combine")

let subscriber = simpleJustPublisher.sink { str in
    print(str)
}
