//
//  CounterViewModel.swift
//  Task1
//
//  Created by Lukasz Fabia on 09/08/2025.
//

import Combine

class CounterViewModel: ObservableObject {
    @Published var counterValue: Int = 0
}
