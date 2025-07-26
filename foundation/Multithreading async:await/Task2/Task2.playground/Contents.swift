import Foundation

func createNewOperation(with sign: String, sleep time: UInt32) -> Operation {
    return BlockOperation {
        print("Operation \"\(sign)\" started")
        sleep(time)
        print("Operation \"\(sign)\" finished")
      }
}
//
//Set the maxConcurrentOperationCountto 6 in operationQueue, add to it all operations and check the console output.
//Set the maxConcurrentOperationCountto 2 and compare the result
//set the dependencies: B depends on C, D depends on B and compare the result
//set the priority lowfor operation A and compare the result
//


let queue = OperationQueue()
//queue.maxConcurrentOperationCount = 6
//queue.maxConcurrentOperationCount = 2


let blockA = createNewOperation(with: "A", sleep: 1)
let blockB = createNewOperation(with: "B", sleep: 1)
let blockC = createNewOperation(with: "C", sleep: 2)
let blockD = createNewOperation(with: "D", sleep: 3)
let blockE = createNewOperation(with: "E", sleep: 5)

//blockB.addDependency(blockC)
//blockB.addDependency(blockD)
blockA.queuePriority = .low
blockE.queuePriority = .high

queue.addOperations([blockA, blockB, blockC, blockD, blockE], waitUntilFinished: true)

// exec'ing all ops concurrently cuz maxConcurrentOperationCount = 6 -> 6>number of all ops (5)

// max number of concurrenlty execing tasks is 2 so queue will execing per 2 tasks

// when we are adding dependency for example b depends on a C and D B will be executed when C D will be finished

// when we set queue priority on low task will be executed in any time
