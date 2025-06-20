//
//  AlertDelegate.swift
//  GymApp
//
//  Created by Lukasz Fabia on 20/06/2025.
//

protocol GymCellAlertDisplaying: AnyObject {
    func gymCell(_ cell: GymTableCell, title: String, message: String)
}
