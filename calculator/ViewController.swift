//
//  ViewController.swift
//  calculator
//
//  Created by diego prats on 1/25/15.
//  Copyright (c) 2015 diego prats. All rights reserved.
//

import UIKit
import Darwin

class ViewController: UIViewController {

    //Display Value
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var operandStackLabel: UILabel!
    
    //operand stack
    var operandStack:[Double] = []
    //keeping track of whether we are in middle of a digit or finished
    var inMiddleOfTyping: Bool = false
    //keeping track if a decimal has been added
    var decimalAdded = false
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            inMiddleOfTyping = false
            
        }
    }
    
    
    //func for DIGITS
    @IBAction func appendDigit(sender: UIButton) {
        

        let digit = sender.currentTitle!

        //if first digit pressed
        if !inMiddleOfTyping  {
            display.text = digit
            inMiddleOfTyping = true
            if digit == "." {
                decimalAdded = true
            }
            
        }
        //if second digit pressed
        else {
            
            if digit == "." {
                if decimalAdded {
                    println("cannot add another decimal")
                }
                else {
                    decimalAdded = true
                    display.text = display.text! + digit
                }
            }
            else {

                //add the digit to the current number
                display.text = display.text! + digit
            }
            
        }
    }
    
    
    //adding PI
    @IBAction func addPI() {
        let digit = M_PI
        displayValue =  digit
    }
    
    
    //func for ENTER
    @IBAction func enter() {
        inMiddleOfTyping = false
        decimalAdded = false
        
        //add the display to the operandStack
        operandStack.append(displayValue)
        println("operandStack = \(operandStack)")
        operandStackLabel.text = "\(operandStack)"
    }
    
    
    //func for an OPERATION
    @IBAction func operate(sender: UIButton) {
        enter()
        let operation = sender.currentTitle!
        println("operandStack = \(operandStack)")
        println("operation = \(operation)")
        
        
        //perform the last operation pressed on the last two digits
        // 5 = performOperation("add")
        switch operation{
            case "+":
                performOperation({$1 + $0})
            case "−":
                performOperation({$1 - $0})
            case "×":
                performOperation({$1 * $0})
            case "÷":
                performOperation({$1 / $0})
            case "SIN":
                performTrig({ sin($0) })
            case "COS":
                performTrig({ cos($0) })
            
            default:
                break
        }
    }
    
    func performOperation(operation: (Double,Double) -> Double) {
            if operandStack.count >= 2 {
                displayValue = operation(operandStack.removeLast(),operandStack.removeLast())
                
                //add the result to the stack
                enter()
            }

    }
    
    //function used by the Trig buttons to perform operations 
    //based on which trug function was selected
    func performTrig(operation: (Double)-> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    //function to clear the history stack label, and previous history
    @IBAction func clear() {
        
        display.text = "0"
        operandStack = []
        println("everything cleared")
        operandStackLabel.text = ""
    }
    

}



