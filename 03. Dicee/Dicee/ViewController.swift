//
//  ViewController.swift
//  Dicee
//
//  Created by Mutlu Calkan on 13.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var diceImageLeft: UIImageView!
    @IBOutlet weak var diceImageRight: UIImageView!
    @IBOutlet weak var nameOfRollLabel: UILabel!
    
    var randomDiceIndex1: Int = 0
    var randomDiceIndex2: Int = 0
    
    let diceArray = ["dice1", "dice2", "dice3", "dice4", "dice5", "dice6"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func rollButtonPressed(_ sender: Any) {
        
        changeImage()
        
    }
    
    func changeImage() {
        randomDiceIndex1 = Int(arc4random_uniform(6))
        randomDiceIndex2 = Int(arc4random_uniform(6))
        // Generate random numbers 0(value that I assigned to 'randomDiceIndex1') to 5 (I assigned '6' to 'arc4random_uniform' so it will be 6-1=5).
        
        diceImageLeft.image = UIImage(named: diceArray[randomDiceIndex1])
        diceImageRight.image = UIImage(named: diceArray[randomDiceIndex2])
        // Dice image changes randomly through 'diceArray' which includes generated random numbers.
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        changeImage()
    }
    
}

