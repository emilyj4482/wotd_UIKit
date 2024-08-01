//
//  ThenViewModel.swift
//  wotd_UIKit
//
//  Created by EMILY on 30/07/2024.
//

import Foundation
import Combine

protocol ThenViewDelegate {
    func pushComparisionViewController(with weather: ThenWeather)
}

final class ThenViewModel: ObservableObject {
    static let shared = ThenViewModel()
    
    private var subscriptions = Set<AnyCancellable>()
    
    let isEmpty: Bool = false
    
    @Published var weathers: [ThenWeather] = []
    
    
    @Published var todaysWeather: ThenWeather? {
        didSet {
            print(todaysWeather ?? "[todaysWeather] nil")
        }
    }
    
    
    init() {
        bind()
        weathers.append(ThenWeather(date: Date() - 2592000, city: "London", min: 7, max: 16, morning: 9, afternoon: 16, evening: 11, night: 7))
        
    }
    
    func bind() {
        let vm = NowViewModel.shared
        
        vm.location
            .combineLatest(vm.weatherInfo)
            .receive(on: DispatchQueue.main)
            .map { (location, weatherInfo) in
                return (location, weatherInfo.temperature)
            }
            .map { location, temp in
                return ThenWeather(date: Date(), city: location, min: temp.max.toInt, max: temp.max.toInt, morning: temp.morning.toInt, afternoon: temp.afternoon.toInt, evening: temp.evening.toInt, night: temp.night.toInt)
            }
            .sink { [weak self] thenWeather in
                self?.todaysWeather = thenWeather
            }
            .store(in: &subscriptions)
    }
}
