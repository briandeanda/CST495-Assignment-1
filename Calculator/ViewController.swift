//
//  ViewController.swift
//  Calculator
//
//  Created by Brian De Anda on 9/13/15.
//  Copyright (c) 2015 Brian De Anda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var displayOperations: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTypingANumber{
            if((digit == "." && display.text!.rangeOfString(".") == nil) || digit != "."){
                display.text = display.text! + digit
            }
        }
        else{
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
        
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        
        if userIsInTheMiddleOfTypingANumber{
            enter()
        }
        switch operation{
        case "×": operandDisplayStack.append("×")
                performOperation{$0 * $1}
        case "÷": operandDisplayStack.append("÷")
                performOperation{$0 / $1}
        case "+": operandDisplayStack.append("+")
                performOperation{$0 + $1}
        case "-": operandDisplayStack.append("-")
                performOperation{$0 - $1}
        case "√": operandDisplayStack.append("√")
                performOperation{sqrt($0)}
        case "sin": operandDisplayStack.append("sin")
                performOperation{sin($0)}
        case "cos": operandDisplayStack.append("cos")
                performOperation{cos($0)}
        default: break
        }
    }
    
    @IBAction func clear(sender: AnyObject) {
        display.text = "0"
        displayOperations.text = ""
        operandStack.removeAll()
    }
    
    private func performOperation(operation: (Double, Double) -> Double){
        if operandStack.count >= 2{
            var temp2 = operandStack.removeLast()
            var temp1 = operandStack.removeLast()
            displayOperations.text = temp1.description + operandDisplayStack.removeLast() + temp2.description + " ="
            displayValue = operation(temp1, temp2)
            enter()
        }
    }
    
    private func performOperation(operation: Double -> Double){
        if operandStack.count >= 1{
            var temp1 = operandStack.removeLast()
            displayOperations.text = operandDisplayStack.removeLast() + "(" + temp1.description  + ") ="
            operandDisplayStack.append(temp1.description)
            displayValue = operation(temp1)
            enter()
        }
    }
    
    var operandStack = Array<Double>()
    var operandDisplayStack = Array<String>()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
    }
    
    var displayValue: Double{
        get{
            if(display.text! == "π"){
                return M_PI
            }
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
}

