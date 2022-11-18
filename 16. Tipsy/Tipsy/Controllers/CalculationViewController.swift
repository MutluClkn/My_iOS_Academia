//
//  CalculationViewController.swift
//  Tipsy
//
//  Created by Mutlu Çalkan on 18.11.2022.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import UIKit

class CalculationViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPercentButton: UIButton!
    @IBOutlet weak var tenPercentButton: UIButton!
    @IBOutlet weak var twentyPercentButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var calculation = Calculation()
    
    var tip = 0.0
    var buttonTitle = ""
    var stepper = 0.0
    var stepperValue = ""
    var total = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func tipChanged(_ sender: UIButton) {
        zeroPercentButton.isSelected = false
        tenPercentButton.isSelected = false
        twentyPercentButton.isSelected = false
        sender.isSelected = true
        buttonTitle = String(sender.currentTitle!.dropLast())
        
        tip = calculation.calculateTip(title: buttonTitle)
        
        billTextField.endEditing(true)
    }
    
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        stepper = sender.value
        stepperValue = String(Int(stepper))
        splitNumberLabel.text = stepperValue
        
        billTextField.endEditing(true)
    }
    
    @IBAction func calculateDidPress(_ sender: UIButton) {
        let bill = billTextField.text!
        if bill != ""{
            total = calculation.totalCalculation(bill: bill, tip: tip, stepper: stepper)
        }
        self.performSegue(withIdentifier: "toResultVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResultVC"{
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.totalResult = total
            destinationVC.settings = "Split between \(stepperValue) people, with \(buttonTitle)% tip."
        }
    }
}
