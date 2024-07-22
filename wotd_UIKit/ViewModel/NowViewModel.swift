//
//  NowViewModel.swift
//  wotd_UIKit
//
//  Created by EMILY on 20/07/2024.
//

import Foundation

final class NowViewModel: ObservableObject {
    
    static let shared = NowViewModel()
    
    @Published var location: String
    
    init(location: String = "Suwon") {
        self.location = location
    }
    
}
