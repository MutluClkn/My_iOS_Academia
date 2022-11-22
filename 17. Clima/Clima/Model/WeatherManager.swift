//
//  WeatherManager.swift
//  Clima
//
//  Created by Mutlu Çalkan on 22.11.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let api_Key = "987329bc91f6216677fbf31bf4b51a8b"
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&units=metric"
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&appid=\(api_Key)&q=\(cityName)"
    }
}
