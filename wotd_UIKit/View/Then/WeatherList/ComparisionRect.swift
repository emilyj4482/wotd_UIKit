//
//  ComparisionRect.swift
//  wotd_UIKit
//
//  Created by EMILY on 09/08/2024.
//

import UIKit
import SnapKit
// import Combine

final class ComparisionRect: UIView {
    
    // private let vm = SettingViewModel.shared
    
    // private var subscriptions = Set<AnyCancellable>()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        
        label.font = .preferredFont(forTextStyle: .title1)
        
        return label
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        
        label.font = .preferredFont(forTextStyle: .title2)
        
        return label
    }()
    
    private lazy var momentStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private lazy var dayStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private lazy var minLabel: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var maxLabel: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .right
        
        return label
    }()
    
    private lazy var temperatureBar = TemperatureBar()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubviews()
        figure()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        [dateLabel, cityLabel, dayStackView, minLabel, maxLabel, temperatureBar].forEach { addSubview($0) }
        // [timeLabel, tempLabel].forEach { momentStackView.addArrangedSubview($0) }
    }
    
    private func figure() {
        backgroundColor = .moreAccent
        layer.cornerRadius = 15
        
        
        [dateLabel, cityLabel, minLabel, maxLabel, timeLabel, tempLabel].forEach { $0.textColor = .accent }
    }
    
    private func layout() {
        
        let offset: CGFloat = 20
        
        snp.makeConstraints {
            $0.height.equalTo(260)
        }
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(offset)
            $0.centerY.equalToSuperview().offset(-offset)
        }
        
        cityLabel.snp.makeConstraints {
            $0.leading.equalTo(dateLabel.snp.leading)
            $0.top.equalTo(dateLabel.snp.bottom).offset(5)
        }
        /*
        momentStackView.snp.makeConstraints {
            $0.leading.equalTo(dateLabel.snp.trailing).offset(50)
        }
         */
        
        minLabel.snp.makeConstraints {
            $0.width.equalTo(30)
            $0.leading.equalToSuperview().offset(22)
            $0.bottom.equalToSuperview().offset(-offset)
        }
        
        maxLabel.snp.makeConstraints {
            $0.width.equalTo(30)
            $0.trailing.equalToSuperview().offset(-22)
            $0.bottom.equalTo(minLabel.snp.bottom)
        }
        
        temperatureBar.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(minLabel.snp.centerY)
        }
    }
    
    func bind(_ weather: ThenWeather) {
        dateLabel.text = weather.date.dateString
        cityLabel.text = weather.city
        timeLabel.text = "9AM"
        tempLabel.text = weather.morning.toString
        minLabel.text = weather.min.toString
        maxLabel.text = weather.max.toString
    }
}
