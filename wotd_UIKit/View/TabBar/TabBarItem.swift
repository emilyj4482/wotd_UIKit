//
//  TabBarItem.swift
//  wotd_UIKit
//
//  Created by EMILY on 21/07/2024.
//

import UIKit

enum TabBarItem: CaseIterable {
    case now
    case then
    case settings
    
    var title: String {
        switch self {
        case .now: return "Now"
        case .then: return "Then"
        case .settings: return "Settings"
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .now:
            return UIImage(systemName: "clock.arrow.circlepath")
        case .then:
            return UIImage(systemName: "calendar")
        case .settings:
            return UIImage(systemName: "gear")
        }
    }
    
    var viewController: UIViewController {
        switch self {
        case .now:
            return NowViewController()
        case .then:
            return UINavigationController(rootViewController: ThenViewController())
        case .settings:
            return UINavigationController(rootViewController: SettingViewController())
        }
    }
}
