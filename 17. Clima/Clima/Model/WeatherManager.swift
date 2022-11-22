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
    let units = "metric"
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?"
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&appid=\(api_Key)&units=\(units)&q=\(cityName)"
//        print(urlString) // Checked the result on browser search bar.
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String){
        // ----  STEPS  ----
        // 1. Create a URL,
        
        if let url = URL(string: urlString){
            
            // 2. Create a URLSession,
            
            let urlSession = URLSession(configuration: .default)
            
            // 3. Give the session a task,
            
            let task = urlSession.dataTask(with: url, completionHandler: handler(data: response: error: ))
            
            // 4. Start the task.
            
            task.resume()
        }
    }
    
    func handler(data: Data?, response: URLResponse?, error: Error?){
        if error != nil {
            print(error?.localizedDescription ?? "Handler error!")
        }
        
        if let data{
            let dataString = String(data: data, encoding: .utf8)
//            print(dataString as Any) // Checked if I can fetch the datas.
        }
    }
}
