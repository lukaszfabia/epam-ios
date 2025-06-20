//
//  Date.swift
//  GymApp
//
//  Created by Lukasz Fabia on 19/06/2025.
//

import Foundation

extension Date {
    
    enum DateFormat: String {
        case prettyDate = "dd MMM yyyy"
        case clearTime = "HH:mm"
        case dayname = "EEEE"
    }
    
    func formatted(as format: DateFormat, locale: Locale = Locale(identifier: "en_US")) -> String {
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.dateFormat = format.rawValue
        return formatter.string(from: self)
    }
}
