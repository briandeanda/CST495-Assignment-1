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
    
    var userIsInTheMiddleOfTypingANumber = false

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTypingANumber{
            println(" imhere")
            if((digit == "." && display.text!.rangeOfString(".") == nil) || digit != "."){
                display.text = display.text! + digit
                
            }
        }
        else{
            if(digit != "." && display.text! != "."){
                display.text = digit
                userIsInTheMiddleOfTypingANumber = true
            }
        }
        
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        
        if userIsInTheMiddleOfTypingANumber{
            enter()
        }
        switch operation{
        case "×": performOperation{$0 * $1}
        case "÷": performOperation{$0 / $1}
        case "+": performOperation{$0 + $1}
        case "-": performOperation{$0 - $1}
        case "√": performOperation{sqrt($0)}
        default: break
        }
    }
    
    private func performOperation(operation: (Double, Double) -> Double){
        if operandStack.count >= 2{
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    private func performOperation(operation: Double -> Double){
        if operandStack.count >= 1{
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        println(operandStack)
    }
    
    var displayValue: Double{
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            
            userIsInTheMiddleOfTypingANumber = false
        }
    }
}

