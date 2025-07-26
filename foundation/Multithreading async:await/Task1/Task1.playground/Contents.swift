import Foundation

let mainQueue = OperationQueue.main
let queue = OperationQueue()
// order guarantee
//queue.maxConcurrentOperationCount = 2

let operation = BlockOperation {
    print(Thread.current)
    print("Operation \"A\" started")
    for _ in 0..<10 {
        // do nothing
        sleep(1)
    }
    print("Operation \"A\" finished")
}

let other = BlockOperation {
    print(Thread.current)

    sleep(3)

    print("end")
}

mainQueue.addOperation(operation)
mainQueue.addOperation {
    print("needed to wait ;/")
    sleep(1)
}
queue.addOperation(other)
queue.addOperation {
    print(Thread.current)
    sleep(1)
    print("one more other done")
}
