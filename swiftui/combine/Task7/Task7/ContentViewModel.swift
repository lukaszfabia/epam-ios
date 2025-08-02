//
//  ContentViewModel.swift
//  Task7
//
//  Created by Lukasz Fabia on 02/08/2025.
//

import Combine
import Foundation

class ContentViewModel {
    let publisher = PassthroughSubject<Int, Never>()
    private(set) var set = Set<AnyCancellable>()
    
    private var clicks = 0
    
    init() {
        obsvereForChanges()
    }
    
    func publishNewValue() {
        clicks+=1
        publisher
            .send(clicks)
    }
    
    func obsvereForChanges() {
        publisher
            .debounce(for: .milliseconds(10), scheduler: DispatchQueue.main)
            .sink { v in
                print("\(Date.now) Received new val: \(v)")
        }.store(in: &set)
    }
}
