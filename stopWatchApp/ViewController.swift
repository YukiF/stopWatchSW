//
//  ViewController.swift
//  stopWatchApp
//
//  Created by Yuki.F on 2015/03/11.
//  Copyright (c) 2015年 Yuki Futagami. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    var startTime : NSTimeInterval? = nil
    var timer : NSTimer?
    var elapsedTime : Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setButtonEnabled(true, stop: false, reset: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setButtonEnabled(start:Bool,stop:Bool,reset:Bool){
        self.startButton.enabled = start
        self.stopButton.enabled = stop
        self.resetButton.enabled = reset
    }

    
    @IBAction func startTimer(sender: AnyObject) {
        setButtonEnabled(false, stop: true, reset: false)
        self.startTime = NSDate.timeIntervalSinceReferenceDate() //since 2001/1/1 0:0:0
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
    }
    
    func update(){
        if let t = self.startTime{
            let time : Double = NSDate.timeIntervalSinceReferenceDate() - t + self.elapsedTime
            let sec : Int = Int(time)
            let msec : Int = Int((time - Double(sec)) * 100)
            self.timeLabel.text = NSString(format: "%02d:%02d:%02d", sec / 60,sec % 60,msec)
        }
        
    }
    
    @IBAction func stopTimer(sender: AnyObject) {
        setButtonEnabled(true, stop: false, reset: true)
        if let t = startTime{
            self.elapsedTime += NSDate.timeIntervalSinceReferenceDate() - t
            self.timer?.invalidate()
            self.timer = nil
        }
    }
    @IBAction func resetTimer(sender: AnyObject) {
        setButtonEnabled(true, stop:false, reset: false)
        self.elapsedTime = 0.0
        self.timer = nil
        self.timeLabel.text = "00:00:00"
    }
    
   

}

/*
command option return : open the assistant area
command option = : upgrade frames


*/

