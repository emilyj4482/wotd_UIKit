//
//  NowViewModel.swift
//  wotd_UIKit
//
//  Created by EMILY on 20/07/2024.
//

import Foundation
import Combine
import Alamofire

final class NowViewModel: ObservableObject {
    
    static let shared = NowViewModel()
    
    private var subscriptions = Set<AnyCancellable>()
    
    let today: CurrentValueSubject<ThreeDays, Never>
    
    
    
    
    
    init() {
        self.today = CurrentValueSubject(ThreeDays(title: "Now", isToday: .today))
        today.value.setDate(dt: Date().dtString, date: Date().dateString)
        setCoordinate()
    }
    
    /*
    func apiTest() {
        Request.moment.setDt(dt: Date().dtString)
        
        let lat = "36.715875"
        let lon = "127.4288454"
        
        Request.moment.setCoordinate(x: lon, y: lat)
        
        printWeather()
    }
    */
    
    func fetchWeather() -> AnyPublisher<WeatherDescription, Error> {
        return AF.request(today.value.currentTempAndCodeRequest.request)
            .publishDecodable(type: WeatherDescription.self)
            .value()
            .mapError { afError in
                return afError as Error
            }
            .eraseToAnyPublisher()
    }
    
    func printWeather() {
        fetchWeather()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("[ERROR] \(error)")
                case .finished:
                    print("[FINISHED]")
                }
            } receiveValue: { weather in
                print("[WEATHER] \(weather)")
            }
            .store(in: &subscriptions)

    }
    
    
    func setCoordinate() {
        LocationManager.shared.coordinates
            .map { ($0.longitude, $0.latitude) }
            .map { (String($0), String($1)) }
            .sink {
                [weak self] lon, lat in
                    self?.today.value.setCoordinates(x: lon, y: lat)
                    print(self?.today.value.currentTempAndCodeRequest)
                    print(self?.today.value.maxAndMinTempRequest)
            }
            
            .store(in: &subscriptions)
    }
}

extension NowViewModel {

}
