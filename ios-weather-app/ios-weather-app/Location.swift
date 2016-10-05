//
//  Location.swift
//  ios-weather-app
//
//  Created by Zoran Todorovic on 05/10/2016.
//  Copyright © 2016 Zoran Todorovic. All rights reserved.
//

import Foundation
import CoreLocation

class Location {
    
    static var sharedInstance = Location()
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
}
