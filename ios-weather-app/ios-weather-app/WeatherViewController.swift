//
//  ViewController.swift
//  ios-weather-app
//
//  Created by Zoran Todorovic on 23/09/2016.
//  Copyright © 2016 Zoran Todorovic. All rights reserved.
//

import UIKit
import Alamofire

class WeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var todayImageView: UIImageView!
    @IBOutlet var todayTemperatureLabel: UILabel!
    @IBOutlet var todayWeatherTypeLabel: UILabel!
    @IBOutlet var todayDateLabel: UILabel!
    @IBOutlet var todayCityLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    var currentWeather: CurrentWeather!
//    var forecast: Forecast!
    var forecastArray = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        currentWeather = CurrentWeather()
        currentWeather.getCurrentWeather {
            self.getForecastData {
                self.updateUI()
            }
            
        }
        
    }

    func getForecastData(completed: @escaping DownloadComplete) -> Void {
        let forecastURL = URL(string: FORECAST_URL)
        
        Alamofire.request(forecastURL!).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecastArray.append(forecast)
//                        print(obj)
                    }
                    self.tableView.reloadData()
                }
            }
            completed()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? WeatherCell {
            
            let forecast = forecastArray[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        } else {
            return WeatherCell()
        }
    }
    
    func updateUI() {
        todayTemperatureLabel.text = "\(currentWeather.currentTemp.description) °C"
        todayWeatherTypeLabel.text = currentWeather.weatherType
        todayCityLabel.text = currentWeather.cityName
        todayDateLabel.text = "Today, \(currentWeather.todayDate)"
        todayImageView.image = UIImage(named: "\(currentWeather.weatherType)")
    }
    
}






