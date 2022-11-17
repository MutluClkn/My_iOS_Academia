//
//  MainViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var heightValueLabel: UILabel!
    @IBOutlet weak var weightValueLabel: UILabel!
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!

    var calculatorModel = Calculator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func heightSliderChanged(_ sender: UISlider) {
        let heightValue = String(format: "%.2f", sender.value)
        heightValueLabel.text = "\(heightValue)m"
    }
    @IBAction func weightSliderChanged(_ sender: UISlider) {
        let weightValue = String(format: "%.0f", sender.value)
        weightValueLabel.text =  "\(weightValue)kg"
    }
    @IBAction func calculateButtonDidPress(_ sender: UIButton) {
        let heightValue = heightSlider.value
        let weightValue = weightSlider.value
        
        calculatorModel.calculateBMI(height: heightValue, weight: weightValue)
        
        self.performSegue(withIdentifier: "toResultVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResultVC"{
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.bmiResult = calculatorModel.getBMIValue()
            destinationVC.advice = calculatorModel.getAdvice()
            destinationVC.color = calculatorModel.getColor()
        }
    }
    
    
}

