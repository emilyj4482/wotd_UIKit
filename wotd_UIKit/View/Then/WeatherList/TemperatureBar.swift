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
        addSubviews()
        subViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        backgroundColor = .tempBar
        layer.cornerRadius = 4
        
        vm.$frameWidth
            .sink { [weak self] width in
                print(width)
                self?.snp.makeConstraints {
                    // 화면 width - (rect과의 간격 20 - 온도 label과의 간격 20 - 온도 label width 30 - 온도 label과 bar의 거리 10) * 2
                    $0.width.equalTo(width - 160)
                    $0.height.equalTo(8)
                }
                return
            }
            .store(in: &subscriptions)
    }
    
    private func comparisionBar(_ width: CGFloat, _ colors: [CGColor]) -> UIView {
        let bar = UIView()
        
        bar.frame.size = CGSize(width: width, height: 8)
        bar.layer.cornerRadius = 4
        
        let gradientLayer = CAGradientLayer(layer: bar)
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = bar.bounds
        gradientLayer.cornerRadius = bar.layer.cornerRadius
        bar.layer.insertSublayer(gradientLayer, at: 0)
        
        bar.layer.shadowColor = UIColor.gray.cgColor
        bar.layer.shadowOpacity = 0.5
        bar.layer.shadowRadius = 10.0
        
        return bar
    }
    
    private lazy var testBar = comparisionBar(174, [UIColor.below10.cgColor, UIColor.below0.cgColor])
    
    private func addSubviews() {
        addSubview(testBar)
    }
    
    private func subViewLayout() {
        testBar.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(30)
        }
    }
}
