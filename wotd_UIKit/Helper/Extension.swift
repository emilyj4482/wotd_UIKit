//
//  Extension.swift
//  wotd_UIKit
//
//  Created by EMILY on 21/07/2024.
//

import Foundation

extension Double {
    // 반올림 한 뒤 Int로 형변환
    var toInt: Int {
        Int(self.rounded())
    }
    
    // n.n°
    var toString: String {
        if self > -0.05 && self <= 0 {
            // -0.0°로 표시되는 것 방지
            return "0.0°"
        } else {
            return "\(String(format: "%.1f", self))°"
        }
    }
}

extension Int {
    // n°
    var toString: String { "\(self)°" }
}
