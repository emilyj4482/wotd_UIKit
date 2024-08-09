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
        // bindTodaysWeather()
        
        // print(view.frame.width)
    }
    
    private func addSubviews() {
        view.addSubview(thenRect)
    }
    
    private func layout() {
        
        let offset: CGFloat = 20
        
        thenRect.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
            $0.centerY.equalToSuperview()
        }
    }
    
    func setThenWeatherInfo() {
        thenRect.bind(weather)
    }
    
    /*
    func bindTodaysWeather() {
        vm.$todaysWeather
            .receive(on: DispatchQueue.main)
            .sink { [weak self] weather in
                self?.cityLabel.text = weather?.city ?? "-"
                self?.maxTempLabel.text = weather?.max.toString ?? "-"
            }
            .store(in: &subscriptions)
    }
     */
}

#Preview {
    ComparisionViewController(weather: ThenWeather(date: Date(), city: "London", min: 0, max: 0, morning: 0, afternoon: 0, evening: 0, night: 0))
}
