//
//  Example3ViewController.swift
//  Week6
//
//  Created by 서동운 on 8/22/23.
//

import UIKit
import Alamofire
import CoreLocation

final class Example3ViewController: UIViewController {
    
    var weatherData = SimpleWeather() {
        didSet {
            tableView.reloadData()
        }
    }
    
    let locationManager = CLLocationManager()
    
    let headerView = HeaderWeatherView()
    let tableView = UITableView()
    
    override func loadView() {
        super.loadView()
        
        view = UIImageView(image: UIImage(named: "back"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpLocationManager()
        checkDeviceLocationAuthorization()
        
        configureTableView()
        configureViews()
        configureViewConstraints()
        
    }
    
    func callWeatherRequest(at latitude: String, longitude: String) {
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(APIKey.weatherKey)&lang=kr"

        AF.request(url).validate().responseDecodable(of: WeatherData.self) { response in
            switch response.result {
            case .success(let weatherData):
                let icon = weatherData.weather[0].icon
                let humidity = weatherData.main.humidity //%
                let temp = weatherData.main.temp // - 273.15
                let wind = weatherData.wind.speed // m/s

                self.weatherData = SimpleWeather(temp: temp, humidity: humidity, icon: icon, wind: wind)
            case.failure(let error):
                print(error)
            }
        }
    }
}
