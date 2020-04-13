//
//  ViewController.swift
//  mm
//
//  Created by Rice Balls on 1/27/20.
//  Copyright © 2020 Rice Balls. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

//Variables:
    var dealerSticks = 50;
    var playerSticks = 20;
    var UIDice = [UIImage(named: "Dice1"),UIImage(named: "Dice2"),UIImage(named: "Dice3"),UIImage(named: "Dice4"),UIImage(named: "Dice5"),UIImage(named:
        "Dice6")];
    var setBetVal = 0;
    var betVals: [Int] = [0,0,0,0,0,0];
    var rndCount = [0,0,0,0,0,0];
    var isAnimatingRoll: Bool = false;
    
    var animateD1: [UIImage] = []
    var animateD2: [UIImage] = []
    var animateD3: [UIImage] = []
//Dice1-3 and (Player/Dealer)Sticks IB outlets:
    //3 Top Dice: UIImage
    @IBOutlet weak var dice1: UIImageView!
    @IBOutlet weak var dice2: UIImageView!
    @IBOutlet weak var dice3: UIImageView!
    
    //"Dealer: 50" "Player: 20" label
    @IBOutlet weak var dSticks: UILabel!
    @IBOutlet weak var pSticks: UILabel!

//Roll IB Action
    //"Roll" Button
    @IBAction func roll(_ sender: UIButton) {

        //No rolling dice during animation
        if(dice3.isAnimating == false){
            //Creates array of random UIdice order. *Note there will be no two repeating numbers/UIdice back to back*:
            animateD1 = createImageArray(total: 5)
            animateD2 = createImageArray(total: 5)
            animateD3 = createImageArray(total: 5)
            
            //Animates dice:
            animate(imageView: dice1, images: animateD1)
            animate(imageView: dice2, images: animateD2)
            animate(imageView: dice3, images: animateD3)
            //Set final dice Images
            dice1.image = animateD1[5];
            dice2.image = animateD2[5];
            dice3.image = animateD3[5];
        }
        
        //Wait for animate to finish animating:
        allocateSticks();
    }
  
//BetValue IB actions and outlet:
    @IBOutlet weak var betValue: UILabel!
    //Change Bet Button/Label +1
    @IBAction func raiseBet(_ sender: UIButton) {
        if setBetVal < playerSticks{
            setBetVal = setBetVal + 1;
            betValue.text = "Bet: " + String(setBetVal);
        }
    }
    //Change Bet Button/Label -1
    @IBAction func lowerBet(_ sender: Any) {
        if setBetVal != 0{
            setBetVal = setBetVal - 1;
            betValue.text = "Bet: " + String(setBetVal);
        }
    }
//SetBetButton IB actions and outlets:
    @IBAction func setD1Act(_ sender: UIButton) {
        setDice(diceTag: 0);
        print(betVals[0]);
    }
    @IBAction func setD2Act(_ sender: UIButton) {
        setDice(diceTag: 1);
    }
    @IBAction func setD3Act(_ sender: UIButton) {
        setDice(diceTag: 2);
    }
    @IBAction func setD4Act(_ sender: UIButton) {
        setDice(diceTag: 3);
    }
    @IBAction func setD5Act(_ sender: UIButton) {
        setDice(diceTag: 4);
    }
    @IBAction func setD6Act(_ sender: UIButton) {
        setDice(diceTag: 5);
    }
    @IBAction func Reset(_ sender: UIButton) {
        let setDOuts = [setD1Out,setD2Out,setD3Out,setD4Out,setD5Out,setD6Out];
        
        playerSticks = 20;
        dealerSticks = 50;
        setSticks();
        setBetVal = 0;
        betValue.text = "Bet: " + String(setBetVal);
        betVals = [0,0,0,0,0,0];
        for i in 0...5 {
            setDOuts[i]!.setTitle( String(betVals[i]) + " Sticks", for: .normal);
        }
    }
    
    
    @IBOutlet weak var setD1Out: UIButton!
    @IBOutlet weak var setD2Out: UIButton!
    @IBOutlet weak var setD3Out: UIButton!
    @IBOutlet weak var setD4Out: UIButton!
    @IBOutlet weak var setD5Out: UIButton!
    @IBOutlet weak var setD6Out: UIButton!
    
//Custom Functions:
    //return random dice image
    public func returnRandomDie() -> UIImage{
        let rng = Int(arc4random_uniform(6));
        rndCount[rng] += 1;
        return UIDice[rng]!;
    }
    public func noRepeat1(){
        randomNumber1 = Int(arc4random_uniform(6));
        if(randomNumber1 == placeHolder1){
            noRepeat1();
        }
    }
    //allocate sticks
    public func allocateSticks(){
        let setDOuts = [setD1Out,setD2Out,setD3Out,setD4Out,setD5Out,setD6Out];
        //for loop:
        var i = 0;
        while(i<6){
            dealerSticks -= betVals[i]*(rndCount[i]);
            if(rndCount[i] != 0){
                rndCount[i] += 1;
            }else{
                dealerSticks += betVals[i];
            }
            playerSticks += betVals[i]*(rndCount[i]);
            betVals[i] = 0;
            rndCount[i] = 0;
            betVals[i] = betVals[i]+setBetVal;
            setDOuts[i]!.setTitle(String(betVals[i]) + " Sticks", for: .normal);

            setSticks();
            i += 1;
        }
        if(playerSticks == 0){
            self.performSegue(withIdentifier: "LostSegue", sender: self)
        }
        if(dealerSticks <= 0){
            self.performSegue(withIdentifier: "WonSegue", sender: self)
        }
    }
    //set dice:
    public func setDice(diceTag: Int){
        let setDOuts = [setD1Out,setD2Out,setD3Out,setD4Out,setD5Out,setD6Out];
        
        if(setBetVal>0){
            //Change Button Titles based on betVal:
            betVals[diceTag] = betVals[diceTag]+setBetVal;
            setDOuts[diceTag]!.setTitle( String(betVals[diceTag]) + " Sticks", for: .normal);
            playerSticks = playerSticks - setBetVal;
            setBetVal = 0;
            //Change label values
            setSticks();
        }
    }
    //Reset labels:
    public func setSticks(){
        betValue.text = "Bet: " + String(setBetVal);
        dSticks.text = "Dealer: " + String(dealerSticks);
        pSticks.text = "Player: " + String(playerSticks);
    }
    //animate imageArray maker
    var randomNumber1 = 0;
    var placeHolder1 = -1;
    func createImageArray(total: Int) -> [UIImage] {
        var imageArray: [UIImage] = []
            for imageCount in 0...total {
                noRepeat1();
                placeHolder1 = randomNumber1;
                let image = UIDice[randomNumber1]!;
                if(imageCount == 5){
                    rndCount[randomNumber1] += 1;
                }
                imageArray.append(image);
            }
        print(rndCount);
        return imageArray;
    }
    func animate(imageView: UIImageView, images: [UIImage]) {
        imageView.animationImages = images;
        imageView.animationDuration = 3.0;
        imageView.animationRepeatCount = 1;
        imageView.startAnimating();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
   
}
