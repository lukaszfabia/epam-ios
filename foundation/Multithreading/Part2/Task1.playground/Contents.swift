import UIKit

import Foundation

//Modify the code to ensure that the UI update happens only after all tasks have completed using DispatchGroup.

func fetchData(from source: String, completion: @escaping () -> Void) {
    print("\(source) - Fetching data...")
    sleep(2) // Simulate network delay
    print("\(source) - Data fetched ✅")
    completion()
}

func runGCDTask() {
    let dispatchGroup = DispatchGroup()
    let queue = DispatchQueue.global(qos: .userInitiated)

    let sources = ["API 1", "API 2", "API 3"]

    for source in sources {
        queue.async(group: dispatchGroup) {
            fetchData(from: source) {
                print("\(source) - Processing complete")
            }
        }
    }
    
    dispatchGroup.wait()

    print("✅ All tasks started. Updating UI...") // 🔴 Issue: This runs before all tasks complete!
}

runGCDTask()
