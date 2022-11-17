//
//  ResultViewController.swift
//  BMI Calculator
//
//  Created by Mutlu Çalkan on 17.11.2022.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var bmiResultLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    
    var bmiResult : String?
    var advice : String?
    var color : UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bmiResultLabel.text = bmiResult
        adviceLabel.text = advice
        view.backgroundColor = color
    }
    
    @IBAction func recalculateDidPress(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
