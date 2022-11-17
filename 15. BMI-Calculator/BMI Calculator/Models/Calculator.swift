//
//  Calculator.swift
//  BMI Calculator
//
//  Created by Mutlu Çalkan on 17.11.2022.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import UIKit

struct Calculator {
    var bmi : BMI?
    
    mutating func calculateBMI(height: Float, weight: Float){
        let bmiValue = weight / pow(height, 2)
        
        if bmiValue < 18.5 {
            bmi = BMI(value: bmiValue, advice: "Eat more kebabs!", color: UIColor.systemMint)
        }else if bmiValue < 24.9{
            bmi = BMI(value: bmiValue, advice: "Fit as a fiddles!", color: UIColor.systemGreen)
        }else{
            bmi = BMI(value: bmiValue, advice: "Eat less kebabs!", color: UIColor.systemRed)
        }
    }
    
    func getBMIValue() -> String {
        if let bmiValue = bmi?.value {
            return String(format: "%.1f", bmiValue)
        }else{
            return "NaN"
        }
    }
    
    func getAdvice() -> String{
        if let advice = bmi?.advice{
            return advice
        }else{
            return "Error"
        }
    }
    
    func getColor() -> UIColor{
        if let color = bmi?.color{
            return color
        }else {
            return UIColor.white
        }
    }
}
