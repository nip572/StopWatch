//
//  ViewController.swift
//  StopWatch
//
//  Created by Nipun Ahuja on 7/30/15.
//  Copyright (c) 2015 Nipun Ahuja. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var Time: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    
    var startTime = NSTimeInterval()
    var elapsedTime = NSTimeInterval()
    var startTimeDate = NSDate()
    var elapsedTimeDate = NSDate()
    var timer = NSTimer()
    
    
    
    //UPDATE TIME FUNCTION
    
    
    func updateTime() {
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        //Find the difference between current time and start time.
        var elapsedTime: NSTimeInterval = currentTime - startTime
        
        //calculate the minutes in elapsed time.
        let minutes = UInt64(elapsedTime / 60.0)
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        
        //calculate the seconds in elapsed time.
        let seconds = UInt64(elapsedTime)
        elapsedTime -= NSTimeInterval(seconds)
        
        //find out the fraction of milliseconds to be displayed.
        let fraction = UInt64(elapsedTime * 100)
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        let strMinutes = minutes > 9 ? String(minutes):"0" + String(minutes)
        let strSeconds = seconds > 9 ? String(seconds):"0" + String(seconds)
        let strFraction = fraction > 9 ? String(fraction):"0" + String(fraction)
        
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        Time.text = "\(strMinutes):\(strSeconds):\(strFraction)"
    }
    
    // END UPDATE TIME FUNCTION
    
    //START BUTTON ACTION
    
    
    
    @IBAction func start(sender: AnyObject) {
        
        
        if !timer.valid {
            let aSelector : Selector = "updateTime"
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
            startTimeDate = NSDate()
            startTime = NSDate.timeIntervalSinceReferenceDate() + elapsedTime
            startButton.setTitle("Pause", forState: UIControlState.Normal)
        } else {
            startButton.setTitle("Continue", forState: UIControlState.Normal)
            elapsedTime += startTimeDate.timeIntervalSinceNow
            timer.invalidate()
        }
        
        
    }
    //START BUTTON ACTION ENDS
    
    
    //RESET BUTTON ACTION START
    
    @IBAction func stop(sender: AnyObject) {
        
        
        
        elapsedTime = 0
        if timer.valid {
            startButton.setTitle("Start", forState: UIControlState.Normal)
            timer.invalidate()
        } else {
            Time.text = "00:00:00"
        }

    }
    
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

