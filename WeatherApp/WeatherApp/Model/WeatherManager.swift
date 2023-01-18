//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Zahraa Herz on 15/01/2023.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManger: WeatherManager ,weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=37c626c4383aeb80bc4319cc038737ef"

     var delegate: WeatherManagerDelegate?
    
    func feachWeather(cityName: String) {
        let stringURL = "\(weatherURL)&q=\(cityName)"
        requestData(urlString: stringURL)
    }
    func feachWeather(latitude:  CLLocationDegrees , longitude:  CLLocationDegrees ) {
        let stringURL = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        requestData(urlString: stringURL)
    }
    
    func requestData(urlString: String){
        
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJson(weatherData: safeData){
                       delegate?.didUpdateWeather(self,weather: weather)
                    }
                }
            }
            task.resume()
            
        }
    }
    
    func parseJson(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decoderData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decoderData.weather[0].id
            let temp = decoderData.main.temp
            let name = decoderData.name
            
            let weather = WeatherModel(id: id, cityName: name, tempreture: temp)
            return weather
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    

}
