//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Zahraa Herz on 16/01/2023.
//

import Foundation

struct WeatherModel{
    let id : Int
    let cityName: String
    let tempreture: Double
    
    var temp: String {
        let tempC = tempreture - 273.15
        return String(format: "%.1f",tempC )
    }
    var condition: String {
        switch id {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...532:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
