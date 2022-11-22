//
//  WeatherData.swift
//  Clima
//
//  Created by Mutlu Çalkan on 22.11.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

// MARK: - WeatherData
struct WeatherData : Codable {
    let id : Int
    let name: String
    let weather : [Weather]
    let main : Main
    let wind : Wind
}

struct Weather : Codable {
    let id : Int
    let main : String
    let description : String
}

struct Main : Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Double
    let humidity: Double
}

struct Wind : Codable {
    let speed : Double
    let deg : Int
}
