//
//  ViewController.swift
//  mm
//
//  Created by Rice Balls on 1/27/20.
//  Copyright © 2020 Rice Balls. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var dealerSticks = 50;
    var playerSticks = 20;
    var UIDice = [UIImage(named: "Dice1"),UIImage(named: "Dice2"),UIImage(named: "Dice3"),UIImage(named: "Dice4"),UIImage(named: "Dice5"),UIImage(named:
        "Dice6")];
    
    @IBOutlet weak var dice1: UIImageView!
    @IBOutlet weak var dice2: UIImageView!
    @IBOutlet weak var dice3: UIImageView!
    
    @IBOutlet weak var dSticks: UILabel!
    @IBOutlet weak var pSticks: UILabel!
    
    @IBAction func roll(_ sender: UIButton) {
        
        dSticks.text = "Dealer: " + String(dealerSticks);
        pSticks.text = "Plauer: " + String(playerSticks);
        
        
        dice1.image = returnRandomDie()
        dice2.image = returnRandomDie()
        dice3.image = returnRandomDie()
    }
    public func returnRandomDie() -> UIImage{
        let rng = Int(arc4random_uniform(6));
        return UIDice[rng]!;
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}




