import UIKit

//Modify the code to ensure that the last task runs only after the first two tasks completeusing DispatchGroup.

// Solution with notification

import Foundation

func executeTask(_ taskNumber: Int, delay: UInt32) {
    print("Task \(taskNumber) started")
    sleep(delay) // Simulate work
    print("Task \(taskNumber) finished")
}

func executeTasks() {
    let dispatchGroup = DispatchGroup()
    let queue1 = DispatchQueue(label: "com.example.queue1", attributes: .concurrent)
    let queue2 = DispatchQueue(label: "com.example.queue2", attributes: .concurrent)
    let queueFinal = DispatchQueue(label: "com.example.finalQueue")

    queue1.async(group: dispatchGroup) {
        executeTask(1, delay: 2)
    }

    queue2.async(group: dispatchGroup) {
        executeTask(2, delay: 3)
    }
    

    dispatchGroup.notify(queue: queueFinal) {
        executeTask(3, delay: 1)
    }
}

// Run the function
executeTasks()

