//
//  SettingSection.swift
//  wotd_UIKit
//
//  Created by EMILY on 04/08/2024.
//

import Foundation

enum SettingSection: Int, CaseIterable {
    case info
    case setting
    
    var cellTitle: [String] {
        switch self {
        case .info: ["Version", "Data Source", "About this App"]
        case .setting: ["Appearance"]
        }
    }
}
