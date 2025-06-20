//
//  GymClasses.swift
//  GymApp
//
//  Created by Lukasz Fabia on 19/06/2025.
//

import Foundation

class GymClasses {
    struct Header: Hashable, Comparable {
        let id: String
        let dayname: String
        
        static func < (lhs: Header, rhs: Header) -> Bool {
            lhs.id < rhs.id
        }
    }
    
    private var classes: [Header: [GymClass]] = [:]
    
    func groupAndSort(my gymClasses: [GymClass]) {
        self.classes = [:]
        
        for gymClass in gymClasses {
            let header = Header(id: gymClass.formattedDate , dayname: gymClass.dayname)
            classes[header, default: []].append(gymClass)
        }

        for (key, value) in classes {
            classes[key] = value.sorted(by: { $0.time < $1.time })
        }
    }
    
    func numberofHeaders() -> Int {
        return classes.count
    }
    
    func numberfoRows(in header: Header) -> Int {
        return classes[header]?.count ?? 0
    }
    
    func allHeadersSorted() -> [Header] {
        return classes.keys.sorted()
    }
    
    func gymClass(at indexPath: IndexPath) -> GymClass? {
        let headers = allHeadersSorted()
        guard indexPath.section < headers.count else { return nil }
        
        let header = headers[indexPath.section]
        let classesForHeader = classes[header] ?? []
        
        guard indexPath.row < classesForHeader.count else { return nil }
        return classesForHeader[indexPath.row]
    }
    
    func header(at section: Int) -> Header? {
        let headers = allHeadersSorted()
        guard section < headers.count else { return nil }
        return headers[section]
    }
    
    func clear() {
        classes.removeAll()
    }
    
    func add(_ gymClass: GymClass) {
        let header = Header(id: gymClass.formattedDate, dayname: gymClass.dayname)
        classes[header, default: []].append(gymClass)
        classes[header]?.sort { $0.time < $1.time }
    }
    
    func removeClass(at indexPath: IndexPath) {
        guard let header = header(at: indexPath.section) else { return }
        classes[header]?.remove(at: indexPath.row)
        
        if let _classes = classes[header], _classes.isEmpty  {
            classes.removeValue(forKey: header)
        }
    }

}
