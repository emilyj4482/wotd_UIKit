//
//  ComparisionViewController.swift
//  wotd_UIKit
//
//  Created by EMILY on 31/07/2024.
//

import UIKit
import SnapKit
import Combine

final class ComparisionViewController: UIViewController {
    
    private let vm = ThenViewModel.shared
    
    private var subscriptions = Set<AnyCancellable>()
    
    let weather: ThenWeather
    
    private lazy var thenRect = ComparisionRect()
    
    private lazy var nowRect = ComparisionRect()
    
    init(weather: ThenWeather) {
        self.weather = weather
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .descent
        
        addSubviews()
        layout()
        setThenWeatherInfo()
        bindTodaysWeather()
    }
    
    private func addSubviews() {
        [thenRect, nowRect].forEach { view.addSubview($0) }
    }
    
    private func layout() {
        
        let offset: CGFloat = 20
        
        thenRect.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
            $0.bottom.equalTo(view.snp.centerY).offset(-10)
        }
        
        nowRect.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
            $0.top.equalTo(view.snp.centerY).offset(10)
        }
    }
    
    func setThenWeatherInfo() {
        thenRect.bind(weather, isToday: false)
        thenRect.thenLayout()
    }
    
    func bindTodaysWeather() {
        vm.$todaysWeather
            .receive(on: DispatchQueue.main)
            .sink { [weak self] weather in
                self?.nowRect.bind(weather, isToday: true)
            }
            .store(in: &subscriptions)
        
        nowRect.nowLayout()
    }
}

#Preview {
    ComparisionViewController(weather: ThenWeather(date: Date(), city: "London", min: 0, max: 0, morning: 0, afternoon: 0, evening: 0, night: 0))
}
