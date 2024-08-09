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
        backgroundColor = .accent
        layer.cornerRadius = 4
        
        vm.$frameWidth
            .sink { [weak self] width in
                print(width)
                self?.snp.makeConstraints {
                    // 화면 width - (rect과의 간격 20 - 온도 label과의 간격 22 - 온도 label width 30 - 온도 label과 bar의 거리 8) * 2
                    $0.width.equalTo(width - 160)
                    $0.height.equalTo(8)
                }
                return
            }
            .store(in: &subscriptions)
    }
}
