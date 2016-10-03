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
    
    init(weatherDict: Dictionary<String, AnyObject>) {
        
        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject> {
            
            if let min = temp["min"] as? Double {
                self.lowTemp = "\(min - 273.15)"
            }
            
            if let max = temp["max"] as? Double {
                self.highTemp = "\(max - 273.15)"
            }
            
            
        }
        
    }
    
}
