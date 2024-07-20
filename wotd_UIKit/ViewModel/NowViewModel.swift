//
//  NowViewModel.swift
//  wotd_UIKit
//
//  Created by EMILY on 20/07/2024.
//

import Foundation

final class NowViewModel: ObservableObject {
    
    static let shared = NowViewModel()
    
    @Published var location: String
    
    init(location: String = "Suwon") {
        self.location = location
    }
    
    let exampleY = NowWeather(dayText: "Yesterday", temp: 23.0, maxTemp: 25, minTemp: 19, code: 502)
    let exampleN = NowWeather(dayText: "Now", temp: 24.5, maxTemp: 27, minTemp: 20, code: 520)
    let exampleT = NowWeather(dayText: "Tomorrow", temp: 20.4, maxTemp: 22, minTemp: 18, code: 801)
}
