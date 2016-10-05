//
//  Constants.swift
//  ios-weather-app
//
//  Created by Zoran Todorovic on 23/09/2016.
//  Copyright © 2016 Zoran Todorovic. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let lat = "lat="
let lon = "&lon="
let appId = "&appid="
let apiKey = "cc4a63e44786d9c3601a6aadb670169e"

typealias DownloadComplete = () -> ()

var latValue = Location.sharedInstance.latitude
var lonValue = Location.sharedInstance.longitude

let currentWeatherURL = "\(BASE_URL)\(lat)\(latValue)\(lon)\(lonValue)\(appId)\(apiKey)"

let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(latValue)&lon=\(lonValue)&cnt=10&mode=json&appid=cc4a63e44786d9c3601a6aadb670169e"

