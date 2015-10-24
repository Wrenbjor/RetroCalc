//
//  ViewController.swift
//  RetroCalc
//
//  Created by Wayne Renbjor on 10/23/15.
//  Copyright © 2015 WCRStudios. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var calcScrene: UILabel!
    
    
    
    var buttonSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValue = ""
    var rightValue = ""
    var currentOpperation: Operation = Operation.Empty
    
    enum Operation : String
    {
        case Devide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Addition = "+"
        case Equals = "="
        case Empty = "Empty"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundURL = NSURL.fileURLWithPath(path!)
        
        do
        {
            try buttonSound = AVAudioPlayer(contentsOfURL: soundURL)
            buttonSound.prepareToPlay()
        }
        catch let err as NSError
        {
            print(err.debugDescription)
        }
        
    }
    
    @IBAction func numberPressed(btn: UIButton)
    {
        playSound()
        
        runningNumber += "\(btn.tag)"
        calcScrene.text = runningNumber
    }

    @IBAction func onDevidePressed(sender: AnyObject)
    {
        processOperation(Operation.Devide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject)
    {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject)
    {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAdditionPressed(sender: AnyObject)
    {
        processOperation(Operation.Addition)
    }
    
    @IBAction func onEqualsPressed(sender: AnyObject)
    {
        processOperation(currentOpperation)

    }
    
    @IBAction func onClearPressed(sender: AnyObject)
    {
        playSound()
        resetAllValues()
    }
    
    func processOperation(opt: Operation)
    {
        playSound()
        if(currentOpperation != Operation.Empty)
        {
            if(leftValue == "")
            {
                leftValue = "0"
            }
            
            if(runningNumber != "")
            {
                rightValue = runningNumber
                runningNumber = ""
                var result = ""
                
                if(currentOpperation == Operation.Multiply)
                {
                    result = "\(Double(leftValue)! * Double(rightValue)!)"
                }
                else if(currentOpperation == Operation.Devide)
                {
                    result = "\(Double(leftValue)! / Double(rightValue)!)"
                }
                else if(currentOpperation == Operation.Subtract)
                {
                    result = "\(Double(leftValue)! - Double(rightValue)!)"
                }
                else if(currentOpperation == Operation.Addition)
                {
                    result = "\(Double(leftValue)! + Double(rightValue)!)"
                }
                
                leftValue = result
                calcScrene.text = result
            }
            
            currentOpperation = opt
        }
        else
        {
            leftValue = runningNumber
            runningNumber = ""
            currentOpperation = opt
        }
        
    }
    
    func playSound()
    {
        if(buttonSound.playing)
        {
            buttonSound.stop()
        }
        
        buttonSound.play()
    }
    
    func resetAllValues()
    {
        runningNumber = ""
        leftValue = ""
        rightValue = ""
        currentOpperation = Operation.Empty
        calcScrene.text = "0"
    }
    
}

