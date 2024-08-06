//
//  ThenViewModel.swift
//  wotd_UIKit
//
//  Created by EMILY on 30/07/2024.
//

import Foundation
import Combine
import SwiftUI

protocol ThenViewDelegate {
    func pushComparisionViewController(with weather: ThenWeather)
    func showActionSheet(_ weather: ThenWeather, index: Int)
}

final class ThenViewModel: ObservableObject {
    static let shared = ThenViewModel()
    
    private var subscriptions = Set<AnyCancellable>()
    
    let notiPublisher = NotificationCenter.default.publisher(for: Notification.tableViewReload)
    
    @Published var weathers: [ThenWeather] = [] {
        didSet {
            saveData()
        }
    }
    
    @Published var todaysWeather: ThenWeather? {
        didSet {
            print(todaysWeather ?? "[todaysWeather] nil")
        }
    }
    
    init() {
        getData()
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
    
    func deleteWeather(_ index: Int) {
        weathers.remove(at: index)
        NotificationCenter.default.post(name: Notification.tableViewReload, object: nil)
    }
}

extension ThenViewModel {
    func saveData() {
        if let encodedData = try? JSONEncoder().encode(weathers) {
            UserDefaults.standard.set(encodedData, forKey: AppStorageKey.weathers)
        }
    }
    
    func getData() {
        guard
            let data = UserDefaults.standard.data(forKey: AppStorageKey.weathers),
            let savedData = try? JSONDecoder().decode([ThenWeather].self, from: data)
        else { return }
        self.weathers = savedData
    }
}
