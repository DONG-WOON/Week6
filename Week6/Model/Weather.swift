//
//  Weather.swift
//  Week6
//
//  Created by 서동운 on 8/22/23.
//

import Foundation
    
struct SimpleWeather {
    let temp: Double
    let humidity: Int
    let icon: String
    let wind: Double
    
    var tempDescription: String {
        return "지금은 \(temp.rounded())°C에요"
    }
    var humidityDescription: String {
        return "\(humidity)%만큼 습해요"
    }
    var windDescription: String {
        return "\(wind)m/s의 바람이 불어요"
    }
    var iconURL: String {
        return "https://openweathermap.org/img/wn/\(icon)@2x.png"
    }
    let lastMessage: String = "오늘도 행복한 하루 보내세요"
    
    var contents: [String] {
        return [tempDescription, humidityDescription, windDescription, iconURL, lastMessage]
    }
    
    init(temp: Double = 273.15, humidity: Int = 0, icon: String = "", wind: Double = 0) {
        self.temp = temp - 273.15
        self.humidity = humidity
        self.icon = icon
        self.wind = wind
    }
}



///////// Response ///////////

// MARK: - WeatherData
struct WeatherData: Codable {
    let main: Main
    let dt: Int
    let weather: [Weather]
    let cod: Int
    let base: String
    let id: Int
    let name: String
    let coord: Coord
    let timezone, visibility: Int
    let sys: Sys?
    let wind: Wind
    let clouds: Clouds
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike: Double
    let pressure: Int
    let tempMax, tempMin: Double
    let grndLevel, seaLevel, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case pressure
        case tempMax = "temp_max"
        case tempMin = "temp_min"
        case grndLevel = "grnd_level"
        case seaLevel = "sea_level"
        case humidity
    }
}

// MARK: - Sys
struct Sys: Codable {
    let sunset: Int
    let country: String
    let id, sunrise, type: Int?
}

// MARK: - Weather
struct Weather: Codable {
    let main: String
    let id: Int
    let icon, description: String
}

// MARK: - Wind
struct Wind: Codable {
    let gust, speed: Double
    let deg: Int
}

