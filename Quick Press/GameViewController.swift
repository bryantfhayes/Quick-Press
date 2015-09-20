//
//  GameViewController.swift
//  Quick Press
//
//  Created by BryantHayes on 9/19/15.
//  Copyright © 2015 Bryant Hayes. All rights reserved.
//

import UIKit

enum ButtonState {
    case grey
    case Orange
    case Red
}

enum GameState {
    case WaitingForButton
    case WaitingForTap
    case WaitingForRedTimeout
}

class Gamedata: NSObject {
    var mode: String?
    var score: Int?
}

class GameViewController: UIViewController {


    @IBOutlet var buttons: [UIButton]!
    
    let orangeImage = "orange_box"
    let greyImage = "grey_box"
    let redImage = "red_box"
    
    var mode: String?
    var currentState: GameState = GameState.WaitingForButton
    var gamemode: Gamemode?
    var updateTimer: NSTimer?
    var buttonStates: [ButtonState] = [ButtonState.grey, ButtonState.grey, ButtonState.grey, ButtonState.grey, ButtonState.grey, ButtonState.grey]
    var lastLitButtonIndex: Int = 0

    var maxTimeToPress: Double = 2.0
    var maxDelayTime: Double = 1.0
    var minTimeToPress: Double = 0.10
    var minDelayTime: Double = 0.10
    var updateInterval: Double = 0.01
    var redFrequency: Double = 0.50
    var delayTimeReductionFactor: Double = 0.9
    var timeToPressReductionFactor: Double = 0.9
    
    var timeLeftToPress: Double = 2.0
    var timeLeftToDelay: Double = 1.0
    var score: Int = 0
    var previousScore: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        gamemode = Gamemode(rawValue: mode!)
        updateTimer = NSTimer.scheduledTimerWithTimeInterval(updateInterval, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    // Set the state of a button and set the color to match.
    func setButtonState(index: Int, state: ButtonState) {
        buttonStates[index] = state
        switch state {
        case .grey:
            buttons[index].setImage(UIImage(named: greyImage), forState: UIControlState.Normal)
        case .Orange:
            buttons[index].setImage(UIImage(named: orangeImage), forState: UIControlState.Normal)
        case .Red:
            buttons[index].setImage(UIImage(named: redImage), forState: UIControlState.Normal)
        }
    }
    
    func randomState() -> ButtonState {
        let tmp: Int = Int(redFrequency * 100)
        if (Int(arc4random_uniform(100)) + 1) <= tmp {
            return ButtonState.Red
        } else {
            return ButtonState.Orange
        }
    }
    
    func lose() {
        print("gameover!")
        updateTimer?.invalidate()
        performSegueWithIdentifier(Segue.GameToPost.rawValue, sender: self)
    }
    
    func update() {
        if score > previousScore {
            previousScore = score
            if maxDelayTime * delayTimeReductionFactor > minDelayTime {
                maxTimeToPress *= delayTimeReductionFactor
            }
            if maxTimeToPress * timeToPressReductionFactor > minTimeToPress {
                maxDelayTime *= timeToPressReductionFactor
            }
        }
        
        if currentState == GameState.WaitingForButton {
            if timeLeftToDelay <= 0 {
                var idx = 0
                repeat {
                    idx = Int(arc4random_uniform(6))
                } while idx == lastLitButtonIndex
                let state: ButtonState = randomState()
                setButtonState(idx, state: state)
                lastLitButtonIndex = idx
                if state == ButtonState.Orange {
                    currentState = GameState.WaitingForTap
                } else if state == ButtonState.Red {
                    currentState = GameState.WaitingForRedTimeout
                }
                timeLeftToDelay = maxDelayTime
            } else {
                timeLeftToDelay -= updateInterval
            }
        } else if currentState == GameState.WaitingForTap {
            if timeLeftToPress <= 0 {
                lose()
                return
            }
            timeLeftToPress -= updateInterval
        } else if currentState == GameState.WaitingForRedTimeout {
            if timeLeftToPress <= 0 {
                setButtonState(lastLitButtonIndex, state: ButtonState.grey)
                currentState = GameState.WaitingForButton
                timeLeftToPress = maxTimeToPress
                score += 1
            } else {
                timeLeftToPress -= updateInterval
            }
        }
    }
    
    @IBAction func didPressButton(sender: AnyObject) {
        if currentState == GameState.WaitingForButton {
            lose()
            return
        } else if currentState == GameState.WaitingForTap {
            if sender.tag == lastLitButtonIndex {
                currentState = GameState.WaitingForButton
                timeLeftToPress = maxTimeToPress
                setButtonState(lastLitButtonIndex, state: ButtonState.grey)
                score += 1
            } else {
                lose()
                return
            }
        } else if currentState == GameState.WaitingForRedTimeout {
            lose()
            return
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Segue.GameToPost.rawValue {
            let vc: PostMenuViewController = segue.destinationViewController as! PostMenuViewController
            vc.score = score
            vc.mode = mode
        }
    }
    

}
