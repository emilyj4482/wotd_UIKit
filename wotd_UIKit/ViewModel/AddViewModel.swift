//
//  AddViewModel.swift
//  wotd_UIKit
//
//  Created by EMILY on 01/08/2024.
//

// import Foundation
import Combine
import UIKit

final class AddViewModel: ObservableObject {
    
    static let shared = AddViewModel()
    
    private let searchManager = SearchManager()
    
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var cities: [City] = [] {
        didSet {
            cities.forEach { print($0.fullName) }
        }
    }
    
    @Published var isCitySelected: Bool = false
    
    func searchCities(searchText: String) {
        cities = searchManager.request(resultType: .address, searchText: searchText)
    }
    
    func setParams(date: Date, city: City) {
        searchManager.setParams(date: date, city: city)
    }
    
    func getWeather(date: Date, city: City) {
        searchManager.fetchWeather(date: date, city: city)
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: { weather in
                ThenViewModel.shared.weathers.append(weather)
                // WeatherListView tableview reload trigger
                NotificationCenter.default.post(name: Notification.tableViewReload, object: nil)
            }
            .store(in: &subscriptions)
    }
}
