//
//  ThreeDays.swift
//  wotd_UIKit
//
//  Created by EMILY on 21/07/2024.
//

import Foundation

enum ThreeDays: String, CaseIterable {
    case yesterday = "Yesterday"
    case today = "Now"
    case tomorrow = "Tomorrow"
    
    var weather: NowWeather {
        switch self {
        case .yesterday:
            return NowWeather(nowTemp: 23.0, maxTemp: 25, minTemp: 19, code: 502)
        case .today:
            return NowWeather(nowTemp: 24.5, maxTemp: 27, minTemp: 20, code: 520)
        case .tomorrow:
            return NowWeather(nowTemp: 20.4, maxTemp: 22, minTemp: 18, code: 801)
        }
    }
    
    var isToday: IsToday {
        switch self {
        case .yesterday: return .notToday
        case .today: return .today
        case .tomorrow: return .notToday
        }
    }
}
