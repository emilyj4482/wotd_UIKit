//
//  AppearanceType.swift
//  wotd_UIKit
//
//  Created by EMILY on 07/08/2024.
//

import UIKit

enum AppearanceType: Int, CaseIterable {
    case system
    case light
    case dark
    
    var modeName: String {
        switch self {
        case .system: "System"
        case .light: "Light"
        case .dark: "Dark"
        }
    }
    
    var icon: String {
        switch self {
        case .system: "🌗"
        case .light: "🌝"
        case .dark: "🌚"
        }
    }
    
    var action: UIAction {
        switch self {
        case .system: UIAction { _ in print(modeName) }
        case .light: UIAction { _ in print(modeName) }
        case .dark: UIAction { _ in print(modeName) }
        }
    }
}
