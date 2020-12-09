//
//  WeatherModel.swift
//  Clima
//
//  Created by Dandy Ferdiansyah on 24/11/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel  {
    let condition: Int
    let cityName: String
    let temprature: Double
    
    var temperatureString: String{
        return String(format: "%.1f",  temprature)
    }
    
    var conditionName: String{
        switch condition {
                case 200...232:
                    return "cloud.bolt"
                case 300...321:
                    return "cloud.drizzle"
                case 500...531:
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
