//
//  NowWeather.swift
//  wotd_UIKit
//
//  Created by EMILY on 21/07/2024.
//

import Foundation

struct NowWeather {
    var nowTemp: Double
    var maxTemp: Int
    var minTemp: Int
    
    var code: Int
    var icon: String {
        // https://openweathermap.org/weather-conditions 참고 weather condition code에 따라 띄울 icon 반환
        switch code {
        case 200, 201, 202, 230, 231, 232:
            return Thunderstorm.rain.systemName
        case 210...221:
            return Thunderstorm.moderate.systemName
        case 300..<400:
            return Rain.drizzle.systemName
        case 500, 520:
            //if isDaytime {
                return Rain.lightDay.systemName
            //} else {
            //    return Rain.lightNight.systemName
            //}
        case 501, 521, 531:
            return Rain.moderate.systemName
        case 502, 503, 504, 522:
            return Rain.heavy.systemName
        case 511, 611...616:
            return Snow.sleet.systemName
        case 600, 620:
            return Snow.light.systemName
        case 601, 602, 621, 622:
            return Snow.moderate.systemName
        case 701:
            return Atmosphere.mist.systemName
        case 711, 721, 741:
            return Atmosphere.fog.systemName
        case 771, 781:
            return Atmosphere.tornado.systemName
        case 731, 751, 761, 762:
            //if isDaytime {
                return Atmosphere.dustDay.systemName
            //} else {
            //    return Atmosphere.dustNight.systemName
            //}
        case 801, 802:
            return Clouds.moderate.systemName
        case 803, 804:
            return Clouds.overcast.systemName
        default:
            //if isDaytime {
                return Clear.day.systemName
            //} else {
            //    return Clear.night.systemName
           // }
        }
    }
    
    var description: String {
        switch code {
        case 200, 201, 202, 230, 231, 232:
            return "Thunderstrom with rain"
        case 210...221:
            return "Thunderstorm"
        case 300..<400:
            return "Drizzle"
        case 500:
            return "Light rain"
        case 501:
            return "Rain"
        case 502...504:
            return "Heavy rain"
        case 511:
            return "Freezing rain"
        case 520...531:
            return "Shower rain"
        case 600:
            return "Light snow"
        case 601:
            return "Snow"
        case 602:
            return "Heavy snow"
        case 611...613:
            return "Sleet"
        case 615, 616:
            return "Rain and snow"
        case 620...622:
            return "Shower snow"
        case 701:
            return "Mist"
        case 711:
            return "Smoke"
        case 721:
            return "Haze"
        case 731, 761:
            return "Dust"
        case 741:
            return "Fog"
        case 751:
            return "Sand"
        case 762:
            return "Volcanic ash"
        case 771:
            return "Squalls"
        case 781:
            return "Tornado"
        case 801, 802:
            return "Clouds"
        case 803, 804:
            return "Overcast clouds"
        default:
            return "Clear"
        }
    }
}
