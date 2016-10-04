//
//  WeatherCell.swift
//  ios-weather-app
//
//  Created by Zoran Todorovic on 04/10/2016.
//  Copyright © 2016 Zoran Todorovic. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet var cellImageView: UIImageView!
    @IBOutlet var cellDayLabel: UILabel!
    @IBOutlet var cellWeatherType: UILabel!
    @IBOutlet var cellHighTemp: UILabel!
    @IBOutlet var cellLowTemp: UILabel!
    
    func configureCell(forecast: Forecast) -> Void {
        cellLowTemp.text = "\(forecast.lowTemp)"
        cellHighTemp.text = "\(forecast.highTemp)"
        cellWeatherType.text = forecast.weatherType
        cellDayLabel.text = forecast.date
        cellImageView.image = UIImage(named: "\(forecast.weatherType) Mini")
    }

}
