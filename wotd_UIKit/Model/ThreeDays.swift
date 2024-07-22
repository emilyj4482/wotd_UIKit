//
//  ThreeDays.swift
//  wotd_UIKit
//
//  Created by EMILY on 21/07/2024.
//

import Foundation

struct ThreeDays {
    let title: String
    let isToday: IsToday
    var weather: NowWeather?
    
    static var yesterday: ThreeDays = ThreeDays(title: "Yesterday", isToday: .notToday)
    static var today: ThreeDays = ThreeDays(title: "Now", isToday: .today)
    static var tomorrow: ThreeDays = ThreeDays(title: "Tomorrow", isToday: .notToday)
}
