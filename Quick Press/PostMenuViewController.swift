//
//  PostMenuViewController.swift
//  Quick Press
//
//  Created by BryantHayes on 9/19/15.
//  Copyright © 2015 Bryant Hayes. All rights reserved.
//

import UIKit

class PostMenuViewController: UIViewController {

    var data: NSMutableArray = ["", 0]
    var score: Int?
    var mode: String?
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var bestScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scoreLabel.text = "SCORE: \(score!)"
        bestScoreLabel.text = "BEST: \(score!)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    // MARK: - UI Action Methods
    
    @IBAction func didPressBackButton(sender: AnyObject) {
        performSegueWithIdentifier(Segue.PostToMain.rawValue, sender: nil)
    }
    
    @IBAction func didPressPlayButton(sender: AnyObject) {
        performSegueWithIdentifier(Segue.PostToGame.rawValue, sender: mode)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Segue.PostToGame.rawValue {
            let vc: GameViewController = segue.destinationViewController as! GameViewController
            vc.mode = sender as? String
        } else if segue.identifier == Segue.PostToMain.rawValue {
        }
    }
    

}
