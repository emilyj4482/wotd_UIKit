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
    
    private let searchManager = SearchManager()
    
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var cities: [City] = [] {
        didSet {
            cities.forEach { print($0.fullName) }
        }
    }
    
    func searchCities(searchText: String) {
        cities = searchManager.request(resultType: .address, searchText: searchText)
    }
    
    func searchWeather(date: Date, city: City?) {
        searchManager.searchWeather(date: date, city: city)
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: { weather in
                ThenViewModel.shared.weathers.append(weather)
                print(weather)
            }
            .store(in: &subscriptions)
    }
}
