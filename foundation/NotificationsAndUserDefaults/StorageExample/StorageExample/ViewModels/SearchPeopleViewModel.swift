//
//  LoginViewModel.swift
//  StorageExample
//
//  Created by Lukasz Fabia on 16/07/2025.
//

import Foundation

class SearchPeopleViewModel {
    let storage: any Storable
    let session: Session
    
    init(storage: any Storable, session: Session) {
        self.storage = storage
        self.session = session
    }
    
    var phrases: [String] {
        storage.get(from: .phrases) as? [String] ?? []
    }
    
    subscript (index: Int) -> String {
        phrases[index]
    }
    
    // saves only five recent phrases
    func saveRecentSearchedPhrase(_ phrase: String?) {
        guard let phrase else { return }
        
        
        var recentPhrases = storage.get(from: .phrases) as? [String] ?? []
        print("recentPhrases \(recentPhrases)")
        
        let size = recentPhrases.count
        
        if size > 4 {
            print("Popping last \(recentPhrases.last!)")
            _ = recentPhrases.popLast()
        }
        
        print("Inserting at 0 \(phrase)")
        recentPhrases.insert(phrase, at: 0)

        storage.set(on: .phrases, value: recentPhrases)
    }
    
    func removeSearchedPhrase(at index: IndexPath) {
        var mutablePhrases = phrases
        
        mutablePhrases.remove(at: index.row)
        
        storage.set(on: .phrases, value: mutablePhrases)
    }
}
