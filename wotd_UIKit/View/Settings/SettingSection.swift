//
//  SettingSection.swift
//  wotd_UIKit
//
//  Created by EMILY on 04/08/2024.
//

import UIKit

enum SettingSection: Int, CaseIterable {
    case info
    case settings
    
    var sectionTitle: String {
        switch self {
        case .info: "info"
        case .settings: "settings"
        }
    }
    
    var cellTitles: [String] {
        switch self {
        case .info: ["Version", "Data Source", "About this App"]
        case .settings: ["Appearance"]
        }
    }
    
    var viewControllers: [UIViewController] {
        switch self {
        case .info: [UIViewController(), DataSourceViewController(), AppInfoViewController()]
        case .settings: [AppearanceViewController()]
        }
    }
}
