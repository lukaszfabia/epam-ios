//
//  GymClass.swift
//  GymApp
//
//  Created by Lukasz Fabia on 19/06/2025.
//

import Foundation

/// Represents gym class entry
final class GymClass {
    
    enum SupportedClasses: String {
        case Streching, Pilates, Yoga, Zumba
    }

    let className: SupportedClasses
    let date: Date
    let duration: Int
    let trainer: Trainer

    var isRegistered: Bool = false
    var isFav: Bool = false

    init(className: SupportedClasses, date: Date, duration: Int, trainer: Trainer) {
        self.className = className
        self.date = date
        self.duration = duration
        self.trainer = trainer
    }

    func toggleIsRegister() {
        isRegistered.toggle()
    }

    func toggleIsFav() {
        isFav.toggle()
    }

    var time: String {
        date.formatted(as: .clearTime)
    }

    var formattedDate: String {
        date.formatted(as: .prettyDate)
    }

    var dayname: String {
        date.formatted(as: .dayname)
    }

    static func dummies() -> [GymClass] {
        let calendar = Calendar.current

        func makeDate(day: Int, hour: Int, minute: Int) -> Date {
            return calendar.date(from: DateComponents(year: 2025, month: 6, day: day, hour: hour, minute: minute))!
        }

        return [
            GymClass(className: .Pilates,  date: makeDate(day: 19, hour: 8,  minute: 30), duration: 45, trainer: Trainer.dummy()),
            GymClass(className: .Yoga,     date: makeDate(day: 19, hour: 10, minute: 0),  duration: 60, trainer: Trainer.dummy()),
            GymClass(className: .Zumba,    date: makeDate(day: 19, hour: 17, minute: 0),  duration: 30, trainer: Trainer.dummy()),
            GymClass(className: .Streching,date: makeDate(day: 19, hour: 18, minute: 0),  duration: 40, trainer: Trainer.dummy()),

            GymClass(className: .Yoga,     date: makeDate(day: 20, hour: 9,  minute: 30), duration: 60, trainer: Trainer.dummy()),
            GymClass(className: .Pilates,  date: makeDate(day: 20, hour: 12, minute: 0),  duration: 45, trainer: Trainer.dummy()),
            GymClass(className: .Zumba,    date: makeDate(day: 20, hour: 16, minute: 15), duration: 30, trainer: Trainer.dummy()),
 
            GymClass(className: .Streching,date: makeDate(day: 21, hour: 8,  minute: 45), duration: 40, trainer: Trainer.dummy()),
            GymClass(className: .Yoga,     date: makeDate(day: 21, hour: 11, minute: 0),  duration: 60, trainer: Trainer.dummy()),
            GymClass(className: .Zumba,    date: makeDate(day: 21, hour: 14, minute: 0),  duration: 30, trainer: Trainer.dummy()),

            GymClass(className: .Pilates,  date: makeDate(day: 22, hour: 7,  minute: 15), duration: 45, trainer: Trainer.dummy()),
            GymClass(className: .Yoga,     date: makeDate(day: 22, hour: 10, minute: 30), duration: 60, trainer: Trainer.dummy()),
            GymClass(className: .Streching,date: makeDate(day: 22, hour: 16, minute: 0),  duration: 40, trainer: Trainer.dummy())
        ]
    }

}
