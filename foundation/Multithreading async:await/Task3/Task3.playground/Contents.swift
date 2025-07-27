import Foundation

func createNewOperation(with sign: String, sleep time: UInt32, cancel operation: Operation? = nil) -> Operation {
    let block = BlockOperation {
        print(Thread.current)
        print("\(Date.now) Operation \"\(sign)\" started")
        sleep(time)
        if let op = operation {
            op.cancel()
            print("Ref to op \(op)")
        }
        print("\(Date.now) Operation \"\(sign)\" finished")
    }
    
    block.name = sign
    
    return block
}

//Set the dependency: B depend on A (operation b should be declared first)
//inside operation A cancel operation B
//enque both operation into operation Queue and check if operation B prints anything to console.
//now run the app and compare the behavior without operation B->A dependency


let queue = OperationQueue()
//queue.maxConcurrentOperationCount = 1

let blockB = createNewOperation(with: "B", sleep: 1)
print("Ref to blockB \(blockB)")
let blockA = createNewOperation(with: "A", sleep: 1, cancel: blockB)

//blockB.addDependency(blockA)
queue.addOperation(blockB)
queue.addOperation(blockA)


