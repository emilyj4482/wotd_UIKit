//
//  APIService.swift
//  wotd_UIKit
//
//  Created by EMILY on 22/07/2024.
//

import Foundation
import Combine
import Alamofire

struct APIService {
    let urlComponent: String
    var params: [String: String]
    
    var queries: [URLQueryItem] {
        params.map { key, value in
            return URLQueryItem(name: key, value: value)
        }
    }
    
    var request: URLRequest {
        var url = URLComponents(string: urlComponent)!
        url.queryItems = queries
        
        var request = URLRequest(url: url.url!)
        request.httpMethod = "GET"
        
        return request
    }
    
    static var moment = APIService(
        urlComponent: "https://api.openweathermap.org/data/3.0/onecall/timemachine?",
        params: [
            "lat": "",
            "lon": "",
            "dt": "",
            "appid": "f27181cb10370ef77a1d09ab93c3fa2f",
            "units": "metric"
        ]
    )
    
    static var day = APIService(
        urlComponent: "https://api.openweathermap.org/data/3.0/onecall/day_summary?",
        params: [
            "lat": "",
            "lon": "",
            "date": "",
            "appid": "f27181cb10370ef77a1d09ab93c3fa2f",
            "units": "metric"
        ]
    )
    
    mutating func setDt(dt: String) {
        params.updateValue(dt, forKey: "dt")
    }
    
    mutating func detDate(date: String) {
        params.updateValue(date, forKey: "date")
    }
    
    mutating func setCoordinate(x: String, y: String) {
        params.updateValue(x, forKey: "lon")
        params.updateValue(y, forKey: "lat")
    }
}
