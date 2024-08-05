//
//  AppInfoSection.swift
//  wotd_UIKit
//
//  Created by EMILY on 06/08/2024.
//

import UIKit

enum AppInfoSection: Int, CaseIterable {
    case app
    case developer
    
    var sectionTitle: String {
        switch self {
        case .app: "App"
        case .developer: "Developer"
        }
    }
    
    var cellTitles: [String] {
        switch self {
        case .app: ["wotd?"]
        case .developer: ["Emily", "emilyj4482@outlook.com", "github.com/emilyj4482"]
        }
    }
    
    var icons: [UIImage?] {
        switch self {
        case .app: []
        case .developer: [UIImage(systemName: "figure"), UIImage(systemName: "envelope.fill"), UIImage(named: "github")]
        }
    }
}
