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

    let gameDescriptions: NSDictionary = ["Classic" : "This is the how to for Classic","Burst" : "This is the how to for Burst","Speed" : "This is the how to for Speed"]
    
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
