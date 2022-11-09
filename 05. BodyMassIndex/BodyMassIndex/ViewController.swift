//
//  ViewController.swift
//  BodyMassIndex
//
//  Created by mutluclkn on 15.02.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var weightText: UITextField!
    @IBOutlet weak var heightText: UITextField!
    @IBOutlet weak var bmiLable: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func calculateButtonPressed(_ sender: Any) {
        bodyMassIndex(weight : Float(weightText.text!) ?? 0, height : Float(heightText.text!) ?? 0)
        
    }
    
    func bodyMassIndex(weight : Float, height : Float) {
        let heightMeter = height / 100
        let calculate = weight / (heightMeter * heightMeter)
        let bmi = "Your body mass index is " + String(format: "%.1f", calculate)
        bmiLable.text = String(bmi)
        if calculate > 25 {
            conditionLabel.text = "You're overweight."
        }else if calculate >= 18.5 && calculate <= 25 {
            conditionLabel.text = "You're normal weight."
        }else {
            conditionLabel.text = "You're underweight."
        }
    }
    
}

