//
//  ViewController.swift
//  ios-weather-app
//
//  Created by Zoran Todorovic on 23/09/2016.
//  Copyright © 2016 Zoran Todorovic. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var todayImageView: UIImageView!
    @IBOutlet var todayTemperatureLabel: UILabel!
    @IBOutlet var todayWeatherTypeLabel: UILabel!
    @IBOutlet var todayDateLabel: UILabel!
    @IBOutlet var todayCityLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation? {
        didSet {
            Location.sharedInstance.latitude = currentLocation!.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation!.coordinate.longitude
            self.getWeather()
        }
    }
    
    var currentWeather: CurrentWeather!
    var forecastArray = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    func getWeather() {
        currentWeather = CurrentWeather()
        currentWeather.getCurrentWeather {
            self.updateUI()
            self.getForecastData()
        }
    }
    
    func locationAuthStatus() -> Void {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            if let currentLocation = locationManager.location {
                Location.sharedInstance.latitude = currentLocation.coordinate.latitude
                Location.sharedInstance.longitude = currentLocation.coordinate.longitude
                print(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude)
            } else {
                print("Cannot get location")
                locationManager.delegate = self
            }
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }

    func getForecastData() {
        let parameters: Parameters = [
            "lat": Location.sharedInstance.latitude,
            "lon": Location.sharedInstance.longitude,
            "appId": apiKey
        ]
        Alamofire.request("http://api.openweathermap.org/data/2.5/forecast/daily", method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {

                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    var temp:[Forecast] = []
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        temp.append(forecast)
                    }
                    self.forecastArray = temp
                    self.tableView.reloadData()
                }
            }
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


extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currLoc = currentLocation, let loc = locations.first  else {
            if let newLoc = locations.first {
                currentLocation = newLoc
            }
            return
        }
        
        if currLoc.distance(from: loc) > 100 {
            currentLocation = loc
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: ", error)
    }
}





