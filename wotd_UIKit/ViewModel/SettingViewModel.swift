//
//  SettingViewModel.swift
//  wotd_UIKit
//
//  Created by EMILY on 06/08/2024.
//

import SwiftUI

protocol SettingDelegate {
    func presentWebView()
}

final class SettingViewModel {
    
    static let shared = SettingViewModel()
    
    @Published var appearance: AppearanceType = .system
    
    @AppStorage(AppStorageKey.colorScheme) var colorSchemeValue: Int = AppStorageKey.defaultColorScheme
    
    init() {
        self.appearance = AppearanceType(rawValue: colorSchemeValue) ?? .system
    }
    
    func changeAppearance(_ willBeAppearance: AppearanceType) {
        appearance = willBeAppearance
        colorSchemeValue = willBeAppearance.rawValue
    }
}
