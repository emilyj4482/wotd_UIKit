//
//  +Int.swift
//  wotd_UIKit
//
//  Created by EMILY on 21/07/2024.
//

import UIKit

extension Int {
    // n°
    var toString: String { "\(self)°" }
    
    var toTempColor: CGColor {
        if self < 0 {
            return UIColor.below0.cgColor
        } else if self >= 0 && self < 5 {
            return UIColor.below5.cgColor
        } else if self >= 5 && self < 10 {
            return UIColor.below10.cgColor
        } else if self >= 10 && self < 13 {
            return UIColor.below13.cgColor
        } else if self >= 13 && self < 16 {
            return UIColor.below16.cgColor
        } else if self >= 16 && self < 23 {
            return UIColor.below23.cgColor
        } else if self >= 23 && self < 27 {
            return UIColor.below27.cgColor
        } else if self >= 27 && self < 35 {
            return UIColor.below35.cgColor
        } else {
            return UIColor.above35.cgColor
        }
    }
}
