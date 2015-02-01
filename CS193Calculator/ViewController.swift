//
//  ViewController.swift
//  CS193Calculator
//
//  Created by diego prats on 1/29/15.
//  Copyright (c) 2015 diego prats. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    //function to change the label when a button is pressed
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle
        println("digit = \(digit)")
    }


}

