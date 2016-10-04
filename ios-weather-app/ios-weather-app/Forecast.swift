//
//  Forecast.swift
//  ios-weather-app
//
//  Created by Zoran Todorovic on 03/10/2016.
//  Copyright © 2016 Zoran Todorovic. All rights reserved.
//

import Foundation
import Alamofire

class Forecast {
    
    var date = ""
    var weatherType = ""
    var highTemp = ""
    var lowTemp = ""
    let today = Date()
    
    init(weatherDict: Dictionary<String, AnyObject>) {
        
        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject> {
            
            if let min = temp["min"] as? Double {
                self.lowTemp = "\(ceil(min - 273.15))"
            }
            
            if let max = temp["max"] as? Double {
                self.highTemp = "\(ceil(max - 273.15))"
            }
    
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>] {
            
            if let main = weather[0]["main"] as? String {
                self.weatherType = main.capitalized
            }
            
        }
        
        if let date = weatherDict["dt"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.dateStyle = .none
            
            let dateComparison = Calendar.current.compare(today, to: unixConvertedDate, toGranularity: .day)
            
            if dateComparison == .orderedSame {
                self.date = "Today"
            } else {
                self.date = unixConvertedDate.dayOfTheWeek()
            }
    
        }
        
    }
    
}


extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}








