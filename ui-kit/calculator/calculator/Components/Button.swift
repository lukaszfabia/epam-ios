//
//  Button.swift
//  calculator
//
//  Created by Lukasz Fabia on 11/06/2025.
//

import UIKit

class Button: UIButton {
    var style: ButtonStyle
    var text: String
    var color : UIColor?
    
    enum ButtonStyle {
        case numeric
        case operation
        case clear
        case equal
    }
    
    init(text: String, style: ButtonStyle = .numeric, color: UIColor? = nil) {
        self.style = style
        self.text = text
        self.color = color
        super.init(frame: .zero)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.configuration = .filled()
        self.configuration?.baseBackgroundColor = color ?? matchColorToStyle()
        self.configuration?.baseForegroundColor = .white
        self.configuration?.title = text

        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    
    func postion() {
        // TODO
    }
    
    private func matchColorToStyle() -> UIColor {
        switch style {
        case .numeric:
            return .lightGray
        case .operation:
            return .systemBlue
        case .clear:
            return .systemRed
        case .equal :
            return .systemGreen
        }
    }
}
