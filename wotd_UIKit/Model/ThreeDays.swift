//
//  ThreeDays.swift
//  wotd_UIKit
//
//  Created by EMILY on 21/07/2024.
//

import Foundation

struct ThreeDays {
    var weather: NowWeather?
    
    // timestamp >>> 그 시각 온도 및 날씨 코드
    var currentTempAndCodeRequest = Request.moment
    
    // 날짜 >>> 그 날의 최고, 최저 온도
    var maxAndMinTempRequest = Request.day
    
    mutating func setDate(dt: String, date: String) {
        currentTempAndCodeRequest.setDt(dt: dt)
        maxAndMinTempRequest.setDate(date: date)
    }
    
    mutating func setCoordinates(x: String, y: String) {
        currentTempAndCodeRequest.setCoordinate(x: x, y: y)
        maxAndMinTempRequest.setCoordinate(x: x, y: y)
    }
}
