//
//  WeatherInfo.swift
//  wotd
//
//  Created by EMILY on 13/12/2023.
//

import Foundation

struct WeatherInfo: Decodable {
    let x: Double
    let y: Double
    let date: String
    let temperature: Temperature
    
    enum CodingKeys: String, CodingKey {
        case x = "lon"
        case y = "lat"
        case date
        case temperature
    }
}

struct Temperature: Decodable {
    let min: Double
    let max: Double
    
    let night: Double       // 00:00
    let morning: Double     // 06:00
    let afternoon: Double   // 12:00
    let evening: Double     // 18:00
}

extension WeatherInfo {
    func toThenWeather(date: Date, city: String) -> ThenWeather {
        .init(date: date, city: city, min: temperature.min.toInt, max: temperature.max.toInt, morning: temperature.morning.toInt, afternoon: temperature.afternoon.toInt, evening: temperature.evening.toInt, night: temperature.night.toInt)
    }
}
