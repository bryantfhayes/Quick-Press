//
//  HowtoViewController.swift
//  Quick Press
//
//  Created by BryantHayes on 9/19/15.
//  Copyright © 2015 Bryant Hayes. All rights reserved.
//

import UIKit

enum Gamemode: String {
    case Classic, Burst, Speed
}

class HowtoViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    let gameDescriptions: NSDictionary = ["Classic" : "In this mode your goal is to press the orange button when it lights up as fast as you can, too so and you lose. Be careful not to press the button if it turns red though!","Burst" : "In this new mode a series of buttons will flash on and off in a particular order. Once finished you will have to press the buttons yourself in the same order as quickly as you can, to slow and you lose!","Speed" : "This mode is similar to Classic but instead of just one button being lit at a time, multiple will light up and you have to press them as quickly as possible. If one button stays orange for too long, oyu lose!"]
    
    var mode: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        titleLabel.text = mode!.uppercaseString
        descriptionLabel.text = gameDescriptions[mode!] as? String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBAction func didPressBackButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: {})
    }
    @IBAction func didPressPlayButton(sender: AnyObject) {
        performSegueWithIdentifier(Segue.HowtoToGame.rawValue, sender: mode)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Segue.HowtoToGame.rawValue {
            let vc: GameViewController = segue.destinationViewController as! GameViewController
            vc.mode = sender as? String
        }
    }


}
