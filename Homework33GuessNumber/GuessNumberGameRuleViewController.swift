//
//  GuessNumberGameRuleViewController.swift
//  Homework33GuessNumber
//
//  Created by 黃柏嘉 on 2021/12/7.
//

import UIKit

class GuessNumberGameRuleViewController: UIViewController {

    @IBOutlet weak var modeSegmentedControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func playGame(_ sender: UIButton) {
        performSegue(withIdentifier: "goPlayGame", sender: nil)
    }
    
    @IBSegueAction func passModeNumber(_ coder: NSCoder) -> GuessNumberPlayGameViewController? {
        if let controller = GuessNumberPlayGameViewController(coder: coder),let selectMode = modeSegmentedControl.titleForSegment(at: modeSegmentedControl.selectedSegmentIndex){
            controller.modeNumber = Int(selectMode)
            return controller
        }else{
            return  nil
            
        }
    }
}
