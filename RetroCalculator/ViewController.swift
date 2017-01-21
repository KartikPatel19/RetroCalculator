//
//  ViewController.swift
//  RetroCalculator
//
//  Created by kartik on 1/22/17.
//  Copyright © 2017 kartik. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var btnSound:AVAudioPlayer!
    
    var currentOperation = Operation.empty
    var runningNumber=""
    var leftValueStr = ""
    var rightValueStr = ""
    var result = ""
    
    enum Operation: String{
        case divide="/"
        case multiply="*"
        case subtract="-"
        case add="+"
        case empty="Empty"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        do{
            try btnSound=AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        }catch let err as NSError{
            print(err.debugDescription)
        }
    }
    @IBOutlet weak var outputLable: UILabel!
    
    
    @IBAction func numberPressed(sender: UIButton){
       playSound()
        
        runningNumber+="\(sender.tag)"
        outputLable.text=runningNumber
    }
    
    @IBAction func onDividePrassed(sender: AnyObject){
        processOperation(operation: Operation.divide)
    }
    @IBAction func onMultiplyPrassed(sender: AnyObject){
        processOperation(operation: Operation.multiply)

    }
    @IBAction func onSubtractPrassed(sender: AnyObject){
        processOperation(operation: Operation.subtract)

    }
    @IBAction func onAddPrassed(sender: AnyObject){
        processOperation(operation: Operation.add)

    }
    @IBAction func onEqualPrassed(sender: AnyObject) {
        processOperation(operation: currentOperation)
    }
    
    @IBAction func onClearPrassed(sender: AnyObject){
        result="0"
        
        processOperation(operation: Operation.empty)
        outputLable.text="0"
    }
    
   
    
    func playSound() {
        if btnSound.isPlaying{
            btnSound.stop()
        }
        btnSound.play()
    }
    
    func processOperation(operation: Operation){
        if currentOperation != Operation.empty{
            if runningNumber != "" {
                rightValueStr=runningNumber
                runningNumber=""
                
                if currentOperation == Operation.multiply{
                    result="\(Double(leftValueStr)!*Double(rightValueStr)!)"
                }else if currentOperation == Operation.divide{
                    result="\(Double(leftValueStr)!/Double(rightValueStr)!)"
                }else if currentOperation == Operation.subtract{
                    result="\(Double(leftValueStr)!-Double(rightValueStr)!)"
                }else if currentOperation == Operation.add{
                    result="\(Double(leftValueStr)!+Double(rightValueStr)!)"
                }
                
                leftValueStr=result
                outputLable.text=result
            }
            currentOperation=operation
        }else{
            leftValueStr=runningNumber
            runningNumber=""
            currentOperation=operation
        }
        
        
    }

}

