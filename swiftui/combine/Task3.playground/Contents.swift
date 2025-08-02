import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

//
//Create 2 publishers: name publisher and surname publisher. Combine the output of 2 publishers this way, that application would print "NAME surname" (name should be capitalized) combination into console. Value transformations should be applied to publishers directly.

let namePublisher = Just("name")
let surnamePublisher = Just("surname")

let subcriber = namePublisher.combineLatest(surnamePublisher) .sink { name, surname in
    print("\(name.uppercased()) \(surname)")
}

