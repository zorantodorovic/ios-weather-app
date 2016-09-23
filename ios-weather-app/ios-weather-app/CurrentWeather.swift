//
//  CurrentWeather.swift
//  ios-weather-app
//
//  Created by Zoran Todorovic on 23/09/2016.
//  Copyright © 2016 Zoran Todorovic. All rights reserved.
//

import Foundation
import Alamofire

class CurrentWeather {
    var cityName = ""
    var weatherType = ""
    var date = ""
    var currentTemp: Double!
    
    var _currentTemp: Double {
        if  currentTemp == nil {
            currentTemp = Double(0)
        }
        return currentTemp
    }
    
    func getCurrentWeather(completed: DownloadComplete) {
        
        let weatherURL = URL(string: currentWeatherURL)!
        
        Alamofire.request(weatherURL).responseJSON { response in
            if let JSON = response.result.value {
                
                if let dict = JSON as? Dictionary<String, AnyObject> {
                    if let name = dict["name"] as? String {
                        self.cityName = name.capitalized
                    }
                    
                    if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                        
                        if let main = weather[0]["main"] as? String {
                            self.weatherType = main.capitalized
                        }
                    }
                    
                    if let main = dict["main"] as? Dictionary<String, AnyObject> {
                        if let currentTemperature = main["temp"] as? Double {
                            self.currentTemp = currentTemperature - 273.15
                        }
                    }
                }
            }
        }
        completed()
    }
    
    
}