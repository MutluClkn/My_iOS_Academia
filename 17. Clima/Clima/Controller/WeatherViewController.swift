//
//  ViewController.swift
//  Clima
//
//  Created by Mutlu Çalkan on 18/11/2022.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

// MARK: - WeatherViewController
class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
        searchTextField.delegate = self
    }

    @IBAction func searchButtonDidPress(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
}


// MARK: - WeatherManagerDelegate at WeatherViewController
extension WeatherViewController: WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, weather : WeatherModel){
        print(weather.temperature)
    }
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }
}


// MARK: - UITextField settings
extension WeatherViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text != "" {
            return true
        }else {
            searchTextField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text{
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
}

