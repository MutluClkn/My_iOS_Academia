//
//  WeatherManager.swift
//  Clima
//
//  Created by Mutlu Çalkan on 22.11.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

// MARK: - WeatherManagerDelegate
protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, weather : WeatherModel)
    func didFailWithError(error: Error)
}

// MARK: - WeatherManager
struct WeatherManager {
    let api_Key = "987329bc91f6216677fbf31bf4b51a8b"
    let units = "metric"
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?"
    
    var delegate : WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&appid=\(api_Key)&units=\(units)&q=\(cityName)"
//      print(urlString) // Checked the result on browser search bar.
        performRequest(with: urlString)
    }
    
//---------------------------------------------------------------------------------------------
    func performRequest(with urlString: String){
        // ----  STEPS  ----
        // 1. Create a URL,
        
        if let url = URL(string: urlString){
            
            // 2. Create a URLSession,
            
            let urlSession = URLSession(configuration: .default)
            
            // 3. Give the session a task,
            
            let task = urlSession.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(delegate?.didFailWithError(error: error!) as Any)
                    return
                }
                if let data{
                    if let weather = self.parseJSON(weatherData: data){
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            
            // 4. Start the task.
            
            task.resume()
        }
    }
//---------------------------------------------------------------------------------------------
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
//          print(weather.temperatureString)
            return weather
        }catch{
            print(delegate?.didFailWithError(error: error) as Any)
            return nil
        }
    }
}
