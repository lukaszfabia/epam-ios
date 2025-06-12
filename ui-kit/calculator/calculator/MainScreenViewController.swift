//
//  ViewController.swift
//  calculator
//
//  Created by Lukasz Fabia on 11/06/2025.
//

import UIKit

/*
0,1,2,3,4
5,6,7,8,9
+,-,/,x =
*/


class MainScreenViewController: UIViewController {
    let clearButton = Button(text: "AC", style: .clear)

    let equalButton = Button(text: MathOperator.eq.rawValue, style: .equal)

    enum MathOperator: String {
        case mul = "*"
        case div = "/"
        case add = "+"
        case sub = "-"
        case eq = "="
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupWindowConfig()
        
        registerButtons()
    
        setPosition()
    }
    
    func setupWindowConfig() {
        view.backgroundColor = .white
    }

    func registerButtons() {
        let numbers = genetateNumberButtons()
        numbers.forEach {view.addSubview($0)}
        
        let operators = generateOperatorButtons()
        operators.forEach {view.addSubview($0)}
        
        view.addSubview(clearButton)
        view.addSubview(equalButton)
    }
    
    func setPosition() {
        NSLayoutConstraint.activate([
            clearButton.centerXAnchor.constraint(equalTo: view.leftAnchor),
            clearButton.centerYAnchor.constraint(equalTo: view.topAnchor),
            
            equalButton.centerXAnchor.constraint(equalTo: view.rightAnchor),
            equalButton.centerYAnchor.constraint(equalTo: view.topAnchor),
        ])
    }

    
    func genetateNumberButtons() -> [Button] {
        let nums = 0...9
        let numberButtons = nums.map { Button(text: String(describing: "\($0)"), style: .numeric) }
        
        return numberButtons
    }
    
    func generateOperatorButtons() -> [Button] {
        let operators: [MathOperator] = [.sub, .add, .mul, .div]
        let operatorsButtons = operators.map {Button(text: $0.rawValue, style: .operation)}
        
        return operatorsButtons
    }

}

