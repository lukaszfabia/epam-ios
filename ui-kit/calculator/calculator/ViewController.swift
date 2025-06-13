//
//  ViewController.swift
//  calculator
//
//  Created by Lukasz Fabia on 12/06/2025.
//

import UIKit

final class ViewController: UIViewController {
    /// Controller used to handle calculator
    /// Scenarios:
    /// 1+1 = -> 2
    /// + 2 = -> 2 (0+2)
    /// . + 2 = -> (0.2 + 2)
    /// 2 op 2 = + 2 = + 2 (assigns res to prev value so ((2+2)+2)+2 = 8)
    
    @IBOutlet weak var expression: UILabel!
    
    /// Defnine more operations for future with out changing main logic in handle compute
    var availableOperations: [MathOperation: (_ lhs: Double,_ rhs: Double) -> Double] = [
        MathOperation.add: {$0 + $1},
        MathOperation.div: {$1 == 0 ? Double.infinity : $0 / $1},
        MathOperation.sub: {$0 - $1},
        MathOperation.mul: {$0 * $1},
    ]
    
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
        if !currentInput.isEmpty && currentInput != "0" {
            print("current input before: ", currentInput)
            currentInput = getProperSignWithInput(currentInput)
            expression.text = currentInput
            print("current input after: ", currentInput)
        } else {
            // we change it for last result
            print("curr prev input before", previousInput)
            previousInput = getProperSignWithInput(previousInput)
            expression.text = previousInput
            print("curr prev input after", previousInput)
        }
        
    }
    
    @IBAction func handleFloatNumbers(_ sender: UIButton) {
        // scenario:
        // 1. user -> .1 -> 0.1
        // 2. user -> 2. -> 2. (if user dont provide the next number default is 0)
        guard !currentInput.contains(".") else {return}
        currentInput.append(".")
        expression.text = currentInput
    }
    
    @IBAction func handleReset(_ sender: UIButton) {
        clearInput()
    }
    
    /// Computes result
    @IBAction func handleCompute(_ sender: UIButton) {
        currentInput = fix(input: currentInput)
        previousInput = fix(input: previousInput)
        
        var result: Double = 0
        let lhs = Double(previousInput) ?? 0
        let rhs = Double(currentInput) ?? 0
        
        guard let mathOperator = operation else {
            expression.text = "\(currentInput)"
            currentInput = "0"
            return
        }
        
        let fn = availableOperations[mathOperator]
        
        guard let compute = fn else {
            notFoundOperation()
            return
        }
        
        result = compute(lhs, rhs)
        
        if result == Double.infinity {
            divisionByZero()
            return
        }
        
        display(result)
    }
    
    /// Fixes input.
    /// * Appends 0 when ends with
    /// * Treats empty as a 0
    /// * Returns fixed: String
    func fix(input: String) -> String {
        if input.isEmpty {return "0"}
        // like 2. -> 2.0
        if input.last == "." {return "\(input)0"}
        
        return input
    }
    
    private func display(_ result: Double) {
        expression.text = "\(result)"
        previousInput = "\(result)"
        currentInput = "0"
        operation = nil
    }
    
    private func notFoundOperation(_ info: String = "Unknown operation") {
        createInfoMessage(info)
    }
    
    private func divisionByZero(_ info: String = "Div/0") {
        createInfoMessage(info)
    }
    
    private func createInfoMessage(_ info: String) {
        clearInput(info)
    }
    
    private func clearInput(_ expressionValue: String? = nil) {
        currentInput = "0"
        previousInput = "0"
        operation = nil
        expression.text = expressionValue ?? currentInput
    }
    
    private func getProperSignWithInput(_ input: String) -> String {
        if input.isEmpty || input == "0" {
            return input
        }
        
        var result = input
        
        if let firstSign = result.first, firstSign == "-" {
            result.remove(at: result.startIndex)
            return result
        }
        
        return "-".appending(result)
    }
}


#Preview {
    ViewController()
}
