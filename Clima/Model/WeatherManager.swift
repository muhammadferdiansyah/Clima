//
//  WeatherManager.swift
//  Clima
//
//  Created by Dandy Ferdiansyah on 23/11/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate{
    func didUpadateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=bce21ee6a83c5ff815f6496af48f5355&q=bogor&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetcWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon\(longitude)"
        performRequest(urlString: urlString)
    }
    
    
    // Networking
    func performRequest(urlString: String){
        // 1. create URL
        if let url = URL(string: urlString){
            // 2. create URL Session
            let session = URLSession(configuration: .default)
            // 3. give task for session
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{ // jika ada error
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data{
                    if let weather = self.parseJSON(weatherData: safeData){
                        self.delegate?.didUpadateWeather(self, weather: weather)
                    }
                }
            }
            
            // 4. start task
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(condition: id, cityName: name, temprature: temp)
            return weather
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

