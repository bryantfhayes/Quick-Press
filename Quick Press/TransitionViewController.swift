//
//  TransitionViewController.swift
//  Quick Press
//
//  Created by BryantHayes on 9/19/15.
//  Copyright © 2015 Bryant Hayes. All rights reserved.
//

import UIKit

class TransitionViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    var mode: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if mode == "howto" {
            titleLabel.text = "HOW TO PLAY"
        } else if mode == "modeselect" {
            titleLabel.text = "SELECT MODE"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func transition(type: String) {
        if mode == "modeselect" {
            performSegueWithIdentifier(Segue.TransitionToGame.rawValue, sender: type)
        } else if mode == "howto" {
            performSegueWithIdentifier(Segue.TransitionToHowto.rawValue, sender: type)
        }
    }
    
    @IBAction func didPressBackButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: {})
    }
    @IBAction func didPressBurstButton(sender: AnyObject) {
        transition(Gamemode.Burst.rawValue)
    }
    @IBAction func didPressClassicButton(sender: AnyObject) {
        transition(Gamemode.Classic.rawValue)
    }
    @IBAction func didPressSpeedButton(sender: AnyObject) {
        transition(Gamemode.Speed.rawValue)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Segue.TransitionToHowto.rawValue {
            let vc: HowtoViewController = segue.destinationViewController as! HowtoViewController
            vc.mode = sender as? String
        } else if segue.identifier == Segue.TransitionToGame.rawValue {
            let vc: GameViewController = segue.destinationViewController as! GameViewController
            vc.mode = sender as? String
        }
    }
    

}
