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

let currentWeatherURL = "\(BASE_URL)\(lat)45.8\(lon)15.96\(appId)\(apiKey)"

let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=45.8&lon=15.96&cnt=10&mode=json&appid=cc4a63e44786d9c3601a6aadb670169e"

