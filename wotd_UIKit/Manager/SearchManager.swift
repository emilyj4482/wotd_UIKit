//
//  SearchManager.swift
//  wotd_UIKit
//
//  Created by EMILY on 01/08/2024.
//

import MapKit
import Combine

final class SearchManager {
    
    private var cities: [City] = []
    
    // keyword가 해당되는 행정구역명 검색하여 결과값을 변수로 전송 >> view model에서 받아서 view로 전송
    func request(resultType: MKLocalSearch.ResultType = .pointOfInterest, searchText: String) -> [City] {
        
        let request = MKLocalSearch.Request()
        
        request.naturalLanguageQuery = searchText
        request.pointOfInterestFilter = .includingAll
        request.resultTypes = resultType
        
        let search = MKLocalSearch(request: request)
        
        search.start { [weak self] response, error in
            guard let response = response else {
                print("[ERROR] \(error?.localizedDescription ?? "Unknown error occured")")
                return
            }
            self?.cities = response.mapItems.map(City.init)
        }
        return cities
    }
    
    // city name으로 좌표 검색
    private func getCoordinate(city: String, completionHandler: @escaping (CLLocationCoordinate2D, NSError?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(city) { placemarks, error in
            if error == nil,
               let placemark = placemarks?[0],
               let location = placemark.location {
                completionHandler(location.coordinate, nil)
            } else {
                completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
            }
        }
    }
    
    private var request = Request.day
    
    func setParams(date: Date, city: City) {
        request.setDate(date: date.dateString)

        getCoordinate(city: city.fullName) { [weak self] coordinate, error in
            let x = String(coordinate.longitude)
            let y = String(coordinate.latitude)
            self?.request.setCoordinate(x: x, y: y)
        }
    }
    
    func fetchWeather(date: Date, city: City) -> AnyPublisher<ThenWeather, Error> {
        print(request)
        return APIService.requestWeatherInfo(request)
            .receive(on: DispatchQueue.main)
            .map { $0.toThenWeather(date: date, city: city.name) }
            .eraseToAnyPublisher()
    }
}
