//
//  Calculation.swift
//  Tipsy
//
//  Created by Mutlu Çalkan on 18.11.2022.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct Calculation{
    func calculateTip(title:String) -> Double{
        let turnToDouble = Double(title)!
        let tip = turnToDouble / 100
        return tip
    }
    
    func totalCalculation(bill:String, tip: Double, stepper:Double) -> String{
        let billDecimal = Double(bill)!
        let total = (billDecimal * (1 + tip)) / stepper
        let totalString = String(format: "%.2f", total)
        return totalString
    }
}
