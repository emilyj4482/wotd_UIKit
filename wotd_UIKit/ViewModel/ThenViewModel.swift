//
//  ThenViewModel.swift
//  wotd_UIKit
//
//  Created by EMILY on 30/07/2024.
//

import Foundation

final class ThenViewModel: ObservableObject {
    static let shared = ThenViewModel()
    
    let isEmpty: Bool = false
    
    @Published var weathers: [ThenWeather] = []
    
    @Published var nowWeather: ThenWeather
    
    init(nowWeather: ThenWeather = ThenWeather(date: Date(), city: "Suwon-si", min: 10, max: 23, morning: 10, afternoon: 23, evening: 17, night: 11)) {
        self.nowWeather = nowWeather
        weathers.append(ThenWeather(date: Date() - 2592000, city: "London", min: 7, max: 16, morning: 9, afternoon: 16, evening: 11, night: 7))
    }
}
