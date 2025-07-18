import UIKit

import Foundation

class Counter: @unchecked Sendable {
    var value = 0
    private let mutex = NSLock()
    
    func increment() {
        mutex.lock()
        value += 1
        mutex.unlock()
    }
}

func runCounterTask() {
    let counter = Counter()
    
    let thread1 = Thread {
        for _ in 1...1000 {
            counter.increment()
        }
    }
    
    let thread2 = Thread {
        for _ in 1...1000 {
            counter.increment()
        }
    }
    
    thread1.start()
    thread2.start()
    
    while thread1.isExecuting || thread2.isExecuting {
        usleep(100)
    }
    
    print("Final counter value: \(counter.value) (Expected: 2000, but will likely be incorrect)")
}

runCounterTask()


/// Down below soltion with DispatchQueue but it is in the next part

//import Foundation
//
//class Counter: @unchecked Sendable {
//    var value = 0
//
//    func increment() {
//        value += 1
//    }
//}
//
//func runCounterTask() {
//    let counter = Counter()
//    let queue = DispatchQueue(label: "myQueue")
//
//    let thread1 = Thread {
//        for _ in 1...1000 {
//            queue.sync {
//                counter.increment()
//            }
//        }
//    }
//
//    let thread2 = Thread {
//        for _ in 1...1000 {
//            queue.sync {
//                counter.increment()
//            }
//        }
//    }
//
//    thread1.start()
//    thread2.start()
//
//    while thread1.isExecuting || thread2.isExecuting {
//        usleep(100)
//    }
//
//    print("Final counter value: \(counter.value) (Expected: 2000, but will likely be incorrect)")
//}
//
//runCounterTask()
