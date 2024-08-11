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
    
    private let vm = ThenViewModel.shared
    
    private var subscriptions = Set<AnyCancellable>()
    
    var offset = PassthroughSubject<(leading: CGFloat, trailing: CGFloat), Never>()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        layout()
        subViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        backgroundColor = .tempBar
        layer.cornerRadius = 4
        
        vm.$tempBarWidth
            .sink { [weak self] width in
                self?.snp.makeConstraints {
                    $0.width.equalTo(width)
                    $0.height.equalTo(8)
                }
                return
            }
            .store(in: &subscriptions)
    }
    
    // 일교차를 보여주는 bar
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

    // 구독한 offset 정보에 따라 일교차 비교 bar의 layout을 정하고 subview로 선언해준다.
    private func subViewLayout() {
        offset
            .sink { [unowned self] leading, trailing in
                let width = vm.tempBarWidth - leading - trailing
                var compBar = comparisionBar(width, [UIColor.below10.cgColor, UIColor.below0.cgColor])
                addSubview(compBar)
                
                compBar.snp.makeConstraints {
                    $0.leading.equalToSuperview().offset(leading)
                    $0.trailing.equalToSuperview().offset(trailing)
                }
            }
            .store(in: &subscriptions)
    }
}
