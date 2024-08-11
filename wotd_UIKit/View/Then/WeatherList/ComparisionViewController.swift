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
            .combineLatest(vm.$tempBarWidth)
            .sink { [unowned self] nowWeather, width in
                guard let nowWeather = nowWeather else { return }
                nowRect.bind(nowWeather, isToday: true)
                getRange(width: width, then: weather, now: nowWeather)
            }
            .store(in: &subscriptions)
        
        nowRect.nowLayout()
    }
}

extension ComparisionViewController {
    // then weather과 now weather의 일교차를 종합하여 온도 비교 bar의 offset값을 계산 후 subview에 전달해준다.
    // 이 때 최저, 최고 기온에 따른 bar의 gradient 색상 또한 전달해준다.
    private func getRange(width: CGFloat, then: ThenWeather, now: ThenWeather) {
        let thenMin = CGFloat(then.min)
        let thenMax = CGFloat(then.max)
        let nowMin = CGFloat(now.min)
        let nowMax = CGFloat(now.max)
        
        let max = max(thenMax, nowMax)
        let min = min(thenMin, nowMin)
        let gap = max - min
        
        let thenLeadingOffset = abs(min - thenMin) * width / gap
        let thenTrailingOffset = abs(max - thenMax) * width / gap
        let nowLeadingOffset = abs(min - nowMin) * width / gap
        let nowTrailingOffset = abs(max - nowMax) * width / gap
        
        thenRect.setOffset(leading: thenLeadingOffset, trailing: thenTrailingOffset, colors: [then.min.toTempColor, then.max.toTempColor])
        nowRect.setOffset(leading: nowLeadingOffset, trailing: nowTrailingOffset, colors: [now.min.toTempColor, now.max.toTempColor])
    }
}

#Preview {
    ComparisionViewController(weather: ThenWeather(date: Date(), city: "London", min: 0, max: 0, morning: 0, afternoon: 0, evening: 0, night: 0))
}
