//
//  ViewController.swift
//  calculator
//
//  Created by Lukasz Fabia on 12/06/2025.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var expression: UILabel!
    
    var currentInput: String = "0"
    var previousInput: String = ""
    var operation: MathOperation?
    
    enum MathOperation: String {
        case mul = "*"
        case sub = "-"
        case add = "+"
        case div = "/"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
    }

    
    @IBAction func handleNumericInput(_ sender: UIButton) {
        // getting value from button
        let val = sender.titleLabel?.text ?? ""
        
        if currentInput == "0" {
            currentInput = val
        } else {
            currentInput += val
        }
        
        expression.text = currentInput
    }
    
    @IBAction func handleOperation(_ sender: UIButton) {
        // getting value from button
        if let inputOperation = sender.titleLabel?.text {
            operation = MathOperation(rawValue: inputOperation)
            previousInput = expression.text ?? ""
            currentInput = ""
        }
    }
    
    
    @IBAction func swapSign(_ sender: UIButton) {
        if let firstSign = currentInput.first, firstSign != "0" {
            if firstSign == "-" {
                currentInput.remove(at: currentInput.startIndex)
            } else {
                currentInput = "-" + currentInput
            }
            
            expression.text = currentInput
        }
        
        
    }
    
    @IBAction func handleFloatNumbers(_ sender: UIButton) {
        // scenario:
        // 1. user -> .1 -> 0.1
        // 2. user -> 2. -> 2. (if user dont provide the next number default is 0)

        currentInput.append(".")
        expression.text = currentInput
    }
    
    @IBAction func handleReset(_ sender: UIButton) {
        currentInput = "0"
        expression.text = currentInput
    }
    
    @IBAction func handleCompute(_ sender: UIButton) {
        
        var result: Double = 0
        let lhs = Double(previousInput) ?? 0
        let rhs = Double(currentInput) ?? 0
        
        if previousInput.isEmpty {
            previousInput = "0"
        }
        
        
        switch operation {
        case .add:
            result = lhs + rhs
        case .sub:
            result = lhs - rhs
        case .mul:
            result = lhs * rhs
        case .div:
            if rhs == 0 {
                let infsign = lhs < 0 ? "-" : ""
                expression.text = "\(infsign)inf"
                return
            }
            
            result = lhs / rhs
            
        case .none:
            print("Unknown operation")
        }
        
        expression.text = "\(result)"
        
        currentInput = "0"
    }
}

