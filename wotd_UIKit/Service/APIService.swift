//
//  APIService.swift
//  wotd_UIKit
//
//  Created by EMILY on 23/07/2024.
//

import Combine
import Alamofire

enum APIService {
    static func requestMoment(_ day: ThreeDays) -> AnyPublisher<WeatherDescription, Error> {
        return AF.request(day.currentTempAndCodeRequest.request)
            .publishDecodable(type: WeatherDescription.self)
            .value()
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
    
    static func requestDay(_ day: ThreeDays) -> AnyPublisher<WeatherInfo, Error> {
        return AF.request(day.maxAndMinTempRequest.request)
            .publishDecodable(type: WeatherInfo.self)
            .value()
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
    
    // 연쇄 호출
    static func requestWeather(_ day: ThreeDays) -> AnyPublisher<(WeatherDescription, WeatherInfo), Error> {
        let fetchedMoment = requestMoment(day)
        let fetchedDay = requestDay(day)
        
        return Publishers.CombineLatest(fetchedMoment, fetchedDay).eraseToAnyPublisher()
    }
    
    static func requestWeatherInfo(_ request: Request) -> AnyPublisher<WeatherInfo, Error> {
        return AF.request(request.request)
            .publishDecodable(type: WeatherInfo.self)
            .value()
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}
