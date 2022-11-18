//
//  ResultViewController.swift
//  Tipsy
//
//  Created by Mutlu Çalkan on 18.11.2022.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    
    var totalResult = ""
    var settings = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalLabel.text = totalResult
        settingsLabel.text = settings
    }
    
    
    @IBAction func recalculateButtonDidPress(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    

}
