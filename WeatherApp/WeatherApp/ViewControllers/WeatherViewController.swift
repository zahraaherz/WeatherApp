//
//  ViewController.swift
//  WeatherApp
//
//  Created by Zahraa Herz on 15/01/2023.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {


    @IBOutlet var locationButton: UIButton!
    @IBOutlet var searchField: UITextField!
    @IBOutlet var weatherTemperature: UILabel!
    @IBOutlet var contryLabel: UILabel!
    
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var weatherIcon: UIImageView!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        weatherManager.delegate = self
        searchField.delegate = self
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    @IBAction func locationButton(_ sender: Any) {
        
        locationManager.requestLocation()
        
    }
    @IBAction func SearchButton(_ sender: UIButton) {
        searchField.endEditing(true)
    }
    
}
//MARK: - UITextFieldDelegate

extension WeatherViewController : UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }else {
            textField.placeholder = "Please write somthing"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchField.text {
            weatherManager.feachWeather(cityName: city)
        }
        searchField.text = ""

    }
    

}
//MARK: - Protocol Delegate Methods

extension WeatherViewController: WeatherManagerDelegate {

    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {

        DispatchQueue.main.async {
            self.weatherTemperature.text = weather.temp
            self.weatherIcon.image = UIImage(systemName: weather.condition)
            self.contryLabel.text = weather.cityName
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }

}

//MARK: - CLLocationManagerDelegate

extension WeatherViewController : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.feachWeather(latitude: lat, longitude: lon)
        }
    }
 
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

