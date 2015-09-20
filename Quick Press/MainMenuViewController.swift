//
//  ViewController.swift
//  Quick Press
//
//  Created by BryantHayes on 9/18/15.
//  Copyright © 2015 Bryant Hayes. All rights reserved.
//

import UIKit

enum Segue: String {
    case MainToTransition  = "mainMenuToTransitionMenu"
    case TransitionToMain  = "transitionMenuToMainMenu"
    case TransitionToGame  = "transitionMenuToGameMenu"
    case TransitionToHowto = "transitionMenuToHowtoMenu"
    case HowtoToGame       = "howtoMenuToGameMenu"
    case GameToPost        = "gameMenuToPostMenu"
    case PostToMain        = "postMenuToMainMenu"
    case PostToGame        = "postMenuToGameMenu"
}

class MainMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    
    // User Interface Element Actions
    @IBAction func didPressPlayButton(sender: AnyObject) {
        // Transition to transitionViewController As Mode Select
        performSegueWithIdentifier(Segue.MainToTransition.rawValue, sender: "modeselect")
    }
    
    @IBAction func didPressHowtoButton(sender: AnyObject) {
        // Transition to transitionViewController As HowTo
        performSegueWithIdentifier(Segue.MainToTransition.rawValue, sender: "howto")
    }
    
    // Segue Options
    override func prepareForSegue(segue: UIStoryboardSegue, sender:AnyObject!) {
        if segue.identifier == Segue.MainToTransition.rawValue {
            let vc: TransitionViewController = segue.destinationViewController as! TransitionViewController
            vc.mode = sender as? String
        }
    }

}

