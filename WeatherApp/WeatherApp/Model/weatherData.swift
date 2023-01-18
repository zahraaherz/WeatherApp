//
//  weatherData.swift
//  WeatherApp
//
//  Created by Zahraa Herz on 16/01/2023.
//

import Foundation

struct WeatherData : Codable {
    
    let name : String
    let main : MainData
    let weather: [Weather]
}

struct MainData: Codable {
    
    let temp: Double
}

struct Weather : Codable{
    
    let id: Int
    let description: String
}
