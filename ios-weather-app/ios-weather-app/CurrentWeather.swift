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
    var currentTemp: Double!
    
    var todayDate: String {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            return dateFormatter.string(from: Date())
        }
    }

    func getCurrentWeather(completed: @escaping DownloadComplete) {
        let parameters: Parameters = [
            "lat": Location.sharedInstance.latitude,
            "lon": Location.sharedInstance.longitude,
            "appId": apiKey
        ]
        Alamofire.request("http://api.openweathermap.org/data/2.5/weather", method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { response in
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
                            self.currentTemp = ceil(currentTemperature - 273.15)
                        }
                    }
                    
                }
            }
            completed()
        }

    }
    
}
