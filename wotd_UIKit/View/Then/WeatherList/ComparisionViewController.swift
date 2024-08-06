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
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        
        label.font = .preferredFont(forTextStyle: .largeTitle)
        
        return label
    }()
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        
        label.font = .preferredFont(forTextStyle: .title1)
        
        return label
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        
        
        label.font = .preferredFont(forTextStyle: .title1)
        
        return label
    }()
    
    private lazy var maxTempLabel: UILabel = {
        let label = UILabel()
        
        label.font = .preferredFont(forTextStyle: .title2)
        
        return label
    }()
    
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
        [dateLabel, tempLabel, cityLabel, maxTempLabel].forEach { view.addSubview($0) }
        
        [dateLabel, tempLabel, cityLabel, maxTempLabel].forEach { $0.textColor = .accent }
        
    }
    
    private func layout() {
        dateLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        tempLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(dateLabel.snp.bottom).offset(20)
        }
        
        cityLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(tempLabel.snp.bottom).offset(50)
        }
        
        maxTempLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(cityLabel.snp.bottom).offset(20)
        }
    }
    
    func setThenWeatherInfo() {
        dateLabel.text = weather.date.dateString
        tempLabel.text = weather.afternoon.toString
    }
    
    func bindTodaysWeather() {
        vm.$todaysWeather
            .receive(on: DispatchQueue.main)
            .sink { [weak self] weather in
                self?.cityLabel.text = weather?.city ?? "-"
                self?.maxTempLabel.text = weather?.max.toString ?? "-"
            }
            .store(in: &subscriptions)
    }
}

#Preview {
    ComparisionViewController(weather: ThenViewModel.shared.weathers[0])
}
