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
    
    let notiPublisher = NotificationCenter.default.publisher(for: Notification.tableViewReload)
    
    @Published var weathers: [ThenWeather] = [] {
        didSet {
            print(weathers)
        }
    }
    
    @Published var todaysWeather: ThenWeather? {
        didSet {
            print(todaysWeather ?? "[todaysWeather] nil")
        }
    }
    
    init() {
        bind()
    }
    
    func bind() {
        let vm = NowViewModel.shared
        
        vm.location
            .combineLatest(vm.weatherInfo)
            .receive(on: DispatchQueue.main)
            .map { location, weatherInfo in
                return weatherInfo.toThenWeather(date: Date(), city: location)
            }
            .sink { [weak self] thenWeather in
                self?.todaysWeather = thenWeather
            }
            .store(in: &subscriptions)
    }
}
