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
    
    @Published var location: String
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(location: String = "오창읍") {
        self.location = location
    }
    
    func apiTest() {
        Request.moment.setDt(dt: Date().dtString)
        
        let lat = "36.715875"
        let lon = "127.4288454"
        
        Request.moment.setCoordinate(x: lon, y: lat)
        
        printWeather()
    }
    
    func fetchWeather() -> AnyPublisher<WeatherDescription, Error> {
        return AF.request(Request.moment.request)
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
}
