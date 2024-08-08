//
//  TemperatureBar.swift
//  wotd_UIKit
//
//  Created by EMILY on 09/08/2024.
//

import UIKit
import SnapKit
import Combine

final class TemperatureBar: UIView {
    
    private let vm = SettingViewModel.shared
    
    private var subscriptions = Set<AnyCancellable>()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        vm.$temperatureBarWidth
            .sink { [weak self] width in
                self?.snp.makeConstraints {
                    $0.width.equalTo(width)
                    $0.height.equalTo(10)
                }
                print("width: \(width)")
                return
            }
            .store(in: &subscriptions)
        
        backgroundColor = .accent
        layer.cornerRadius = 5
    }
}
