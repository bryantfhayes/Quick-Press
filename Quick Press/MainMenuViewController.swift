//
//  ViewController.swift
//  Quick Press
//
//  Created by BryantHayes on 9/18/15.
//  Copyright © 2015 Bryant Hayes. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // User Interface Element Actions
    @IBAction func didPressPlayButton(sender: AnyObject) {
        // Transition to transitionViewController As Mode Select
        performSegueWithIdentifier("mainMenuToTransitionMenu", sender: "modeselect")
    }
    
    @IBAction func didPressHowtoButton(sender: AnyObject) {
        // Transition to transitionViewController As HowTo
        performSegueWithIdentifier("mainMenuToTransitionMenu", sender: "howto")
    }
    
    // Segue Options
    override func prepareForSegue(segue: UIStoryboardSegue, sender:AnyObject!) {
        if segue.identifier == "mainMenuToTransitionMenu" {
            let vc: TransitionViewController = segue.destinationViewController as! TransitionViewController
            vc.mode = sender as! String
        }
    }

}

