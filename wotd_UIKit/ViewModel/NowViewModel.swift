//
//  NowViewModel.swift
//  wotd_UIKit
//
//  Created by EMILY on 20/07/2024.
//

import CoreLocation
import Combine
import Alamofire

final class NowViewModel: NSObject, ObservableObject {

    private let locationManager = CLLocationManager()
    let location = PassthroughSubject<String, Never>()
    
    private var subscriptions = Set<AnyCancellable>()
    
    let today = CurrentValueSubject<ThreeDays, Never>(ThreeDays(title: "Now", isToday: .today))
    let yesterday = CurrentValueSubject<ThreeDays, Never>(ThreeDays(title: "Yesterday", isToday: .notToday))
    let tomorrow = CurrentValueSubject<ThreeDays, Never>(ThreeDays(title: "Tomorrow", isToday: .notToday))
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        setThreeDays()
    }
    
    private func setThreeDays() {
        let now: Date = .now
        
        today.value.setDate(dt: now.dtString, date: now.dateString)
        yesterday.value.setDate(dt: (now - 86400).dtString, date: (now - 86400).dateString)
        tomorrow.value.setDate(dt: (now + 86400).dtString, date: (now + 86400).dateString)
    }

    func fetchWeather() {
        APIService.requestWeather(today.value)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("[COMPLETION] \(completion)")
            } receiveValue: { [weak self] description, info in
                let moment = description.weather[0]
                let day = info.temperature
                self?.today.value.weather = NowWeather(isDaytime: Date().isDayTime, nowTemp: moment.temp, maxTemp: day.max.toInt, minTemp: day.min.toInt, code: moment.description[0].code)
            }
            .store(in: &subscriptions)
    }
}

extension NowViewModel: CLLocationManagerDelegate {
    private func getCityname(_ location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard error == nil, let cityName = placemarks?[0].locality else { return }
            self?.location.send(cityName)
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            print("[Auth] Not determined")
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("[Auth] Restricted")
        case .denied:
            print("[Auth] Denied")
        case .authorizedAlways:
            print("[Auth] Always")
            locationManager.startUpdatingLocation()
        case .authorizedWhenInUse:
            print("[Auth] When in use")
            locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        // 1. 수집한 위치정보의 행정구역명
        getCityname(location)
        // 2. 좌표 정보
        let x = String(location.coordinate.longitude)
        let y = String(location.coordinate.latitude)
        setCoordinates(x: x, y: y)
        // 3. 위치 정보 수집 중지
        manager.stopUpdatingLocation()
        // 4.
        
        fetchWeather()
    }
    
    private func setCoordinates(x: String, y: String) {
        today.value.setCoordinates(x: x, y: y)
        yesterday.value.setCoordinates(x: x, y: y)
        tomorrow.value.setCoordinates(x: x, y: y)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error.localizedDescription)
    }
}
