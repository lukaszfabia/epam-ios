//
//  GymClasses.swift
//  GymApp
//
//  Created by Lukasz Fabia on 19/06/2025.
//

import Foundation

final class FindClubViewModel {
    
    class Section: Comparable {
        let id: String
        let dayName: String
        var classes: [GymClass]
        
        init(gymClass: GymClass) {
            self.id = gymClass.formattedDate
            self.dayName = gymClass.dayname
            self.classes = [gymClass]
        }
        
        static func < (lhs: Section, rhs: Section) -> Bool {
            lhs.id < rhs.id
        }
        
        static func == (lhs: Section, rhs: Section) -> Bool {
            lhs.id == rhs.id
        }
    }
    
    private var sections: [Section] = []
    
    var numberOfSections: Int {
        sections.count
    }
    
    func numberOfRows(in section: Int) -> Int {
        guard section < sections.count else { return 0 }
        return sections[section].classes.count
    }
    
    func section(at index: Int) -> Section? {
        guard index < sections.count else { return nil }
        return sections[index]
    }
    
    func gymClass(at indexPath: IndexPath) -> GymClass? {
        guard indexPath.section < sections.count,
              indexPath.row < sections[indexPath.section].classes.count else {
            return nil
        }
        return sections[indexPath.section].classes[indexPath.row]
    }
    
    func fillData(with gymClasses: [GymClass]) {
        for gymClass in gymClasses {
            if let section = sections.first(where: {$0.id == gymClass.formattedDate}) {
                section.classes.append(gymClass)
            } else {
                sections.append(Section(gymClass: gymClass))
            }
        }
        
        for section in sections {
            section.classes.sort(by: {$0.time < $1.time})
        }
    }
    
    func removeClass(at indexPath: IndexPath) -> (hasDeletedRow: Bool, hasDeletedSection: Bool) {
        guard indexPath.section < sections.count else { return (false, false) }
        
        let emptySectionBeforeRemoving = sections[indexPath.section].classes.count == 1
        sections[indexPath.section].classes.remove(at: indexPath.row)
        
        if sections[indexPath.section].classes.isEmpty {
            sections.remove(at: indexPath.section)
            return (false, true)
        }
        
        return (true, emptySectionBeforeRemoving)
    }
    
    func clear() {
        sections.removeAll()
    }
}
