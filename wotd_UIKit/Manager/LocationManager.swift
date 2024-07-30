//
//  LocationManager.swift
//  wotd_UIKit
//
//  Created by EMILY on 30/07/2024.
//

import CoreLocation

final class LocationManager: NSObject {
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    private func getCityname(_ location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            guard error == nil, let cityName = placemarks?[0].locality else { return }
            NowViewModel.shared.location.send(cityName)
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
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
            // locationManager.startUpdatingLocation()
        case .authorizedWhenInUse:
            print("[Auth] When in use")
            // locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        // 1. 수집한 위치정보의 행정구역명을 view model에 전송
        getCityname(location)
        // 2. 좌표 정보를 view model에 전송 (url 파라미터로 set)
        let x = String(location.coordinate.longitude)
        let y = String(location.coordinate.latitude)
        NowViewModel.shared.setCoordinates(x: x, y: y)
        // 3. 위치 정보 수집 중지
        manager.stopUpdatingLocation()
        // 4. weather api 통신
        NowViewModel.shared.fetchWeather()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error.localizedDescription)
    }
}
