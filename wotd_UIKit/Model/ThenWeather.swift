//
//  ThenWeather.swift
//  wotd_UIKit
//
//  Created by EMILY on 30/07/2024.
//

import Foundation

struct ThenWeather: Hashable, Codable {
    var date: Date
    var city: String
    
    var min: Int
    var max: Int
    
    var morning: Int
    var afternoon: Int
    var evening: Int
    var night: Int
}
