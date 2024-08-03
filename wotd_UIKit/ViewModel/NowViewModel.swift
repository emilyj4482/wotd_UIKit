//
//  NowViewModel.swift
//  wotd_UIKit
//
//  Created by EMILY on 20/07/2024.
//

import Foundation
import Combine

final class NowViewModel: ObservableObject {

    static let shared = NowViewModel()
    
    private var subscriptions = Set<AnyCancellable>()
    
    let location = PassthroughSubject<String, Never>()
    
    let weatherInfo = PassthroughSubject<WeatherInfo, Never>()
    
    let today = CurrentValueSubject<ThreeDays, Never>(ThreeDays())
    let yesterday = CurrentValueSubject<ThreeDays, Never>(ThreeDays())
    let tomorrow = CurrentValueSubject<ThreeDays, Never>(ThreeDays())
    
    init() {
        setThreeDays()
    }
    
    private func setThreeDays() {
        let now: Date = .now
        
        today.value.setDate(dt: now.dtString, date: now.dateString)
        yesterday.value.setDate(dt: (now - 86400).dtString, date: (now - 86400).dateString)
        tomorrow.value.setDate(dt: (now + 86400).dtString, date: (now + 86400).dateString)
    }
    
    func setCoordinates(x: String, y: String) {
        today.value.setCoordinates(x: x, y: y)
        yesterday.value.setCoordinates(x: x, y: y)
        tomorrow.value.setCoordinates(x: x, y: y)
    }

    func fetchWeather() {
        let isDaytime = Date().isDayTime
        
        APIService.requestWeather(today.value)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("[COMPLETION] \(completion)")
            } receiveValue: { [weak self] description, info in
                let moment = description.weather[0]
                let day = info.temperature
                self?.today.value.weather = NowWeather(isDaytime: isDaytime, nowTemp: moment.temp, maxTemp: day.max.toInt, minTemp: day.min.toInt, code: moment.description[0].code)
            }
            .store(in: &subscriptions)
        
        APIService.requestWeather(yesterday.value)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("[COMPLETION] \(completion)")
            } receiveValue: { [weak self] description, info in
                // then view model에 전송하기 위에 publisher에 send
                self?.weatherInfo.send(info)
                let moment = description.weather[0]
                let day = info.temperature
                self?.yesterday.value.weather = NowWeather(isDaytime: isDaytime, nowTemp: moment.temp, maxTemp: day.max.toInt, minTemp: day.min.toInt, code: moment.description[0].code)
            }
            .store(in: &subscriptions)

        APIService.requestWeather(tomorrow.value)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("[COMPLETION] \(completion)")
            } receiveValue: { [weak self] description, info in
                let moment = description.weather[0]
                let day = info.temperature
                self?.tomorrow.value.weather = NowWeather(isDaytime: isDaytime, nowTemp: moment.temp, maxTemp: day.max.toInt, minTemp: day.min.toInt, code: moment.description[0].code)
            }
            .store(in: &subscriptions)
    }
}
