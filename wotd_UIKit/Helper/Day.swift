//
//  Day.swift
//  wotd_UIKit
//
//  Created by EMILY on 30/07/2024.
//

import UIKit

enum Day {
    case yesterday
    case today
    case tomorrow
    
    var isToday: IsToday {
        switch self {
        case .yesterday: .notToday
        case .today: .today
        case .tomorrow: .notToday
        }
    }
    
    var title: String {
        switch self {
        case .yesterday: "Yesterday"
        case .today: "Now"
        case .tomorrow: "Tomorrow"
        }
    }
}

// 오늘 날씨인지 아닌지에 따라 WeatherRect의 style이 달라지기 때문에 분기한다.
enum IsToday {
    case today
    case notToday
    
    var rectHeight: UInt {
        switch self {
        case .today: 220
        case .notToday: 180
        }
    }
    
    var offset: UInt {
        switch self {
        case .today: 38
        case .notToday : 32
        }
    }
    
    var dayLabelFontSize: CGFloat {
        switch self {
        case .today: 30
        case .notToday: 23
        }
    }
    
    var tempLabelFontSize: CGFloat {
        switch self {
        case .today: 60
        case .notToday: 50
        }
    }
    
    var maxminLabelFontStyle: UIFont.TextStyle {
        switch self {
        case .today: .body
        case .notToday: .subheadline
        }
    }
    
    var descriptionLabelFontStyle: UIFont.TextStyle {
        switch self {
        case .today: .subheadline
        case .notToday: .caption1
        }
    }
    
    var weatherIconSize: UInt {
        switch self {
        case .today: 90
        case .notToday : 70
        }
    }
}
