//
//  ViewController.swift
//  Magic 8 Ball
//
//  Created by macbook on 14.02.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    let ballArray = ["ball1","ball2","ball3","ball4","ball5"]
    var randomBallNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        randomBall()
    }
    
    
    @IBAction func askButtonPressed(_ sender: Any) {
        randomBall()
    }
    
    func randomBall() {
        randomBallNumber = Int(arc4random_uniform(5))
        imageView.image = UIImage(named: ballArray[randomBallNumber])
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        randomBall()
        // A function to change image when shaking the phone.
    }

}

