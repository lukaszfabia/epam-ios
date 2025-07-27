//
//  TaskAPIMock.swift
//  AsyncAwaitFinalTask
//
//  Created by Lukasz Fabia on 27/07/2025.
//

@testable import AsyncAwaitFinalTask



class Task5APIMock: Task5API {
    private var millisecondDelayForOne: Int = 50
    private var millisecondDelayForTwo: Int = 100
    private var millisecondDelayForThree: Int = 200
    
    var hasDelay: Bool = true
    
    var checkFor1Of3: Bool = false
    var checkFor2Of3: Bool = false

    
    func loadRequest(_ request: ParallelRequest) async -> String {
        if hasDelay {
            switch request {
            case .one:
                try? await Task.sleep(for: .milliseconds(millisecondDelayForOne))
            case .two:
                try? await Task.sleep(for: .milliseconds(millisecondDelayForTwo))
            case .three:
                try? await Task.sleep(for: .milliseconds(millisecondDelayForThree))
            }
        } else if checkFor1Of3 {
            switch request {
            case .two, .three:
                try? await Task.sleep(for: .seconds(1))
            default:
                print("Skipping")
            }
        } else if checkFor2Of3 {
            switch request {
            case .three:
                try? await Task.sleep(for: .seconds(1))
            default:
                print("Skipping")
            }
        }
        
        return request.rawValue
    }
}
