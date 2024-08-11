//
//  ComparisionRect.swift
//  wotd_UIKit
//
//  Created by EMILY on 09/08/2024.
//

import UIKit
import SnapKit

final class ComparisionRect: UIView {
    
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(cityLabel)
        
        return stackView
    }()
    
    private lazy var dateLabel = UILabel()
    private lazy var cityLabel = UILabel()
    
    private func momentStackView(_ time: String, temp: String) -> UIStackView {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.spacing = 15
        
        let timeLabel = UILabel()
        
        timeLabel.text = time
        timeLabel.textColor = .accent
        timeLabel.font = .monospacedSystemFont(ofSize: 16, weight: .medium)
        timeLabel.textAlignment = .left
        
        let tempLabel = UILabel()
        
        tempLabel.text = temp
        tempLabel.textColor = .accent
        tempLabel.font = .monospacedSystemFont(ofSize: 16, weight: .medium)
        tempLabel.textAlignment = .right
        
        stackView.addArrangedSubview(timeLabel)
        stackView.addArrangedSubview(tempLabel)
        
        return stackView
    }
    
    private lazy var dayStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.spacing = 10
        
        return stackView
    }()
    
    private lazy var minLabel = UILabel()
    private lazy var maxLabel = UILabel()
    
    private lazy var temperatureBar = TemperatureBar()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubviews()
        commonLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        [titleStackView, dayStackView, minLabel, maxLabel, temperatureBar].forEach { addSubview($0) }
    }
    
    private func commonLayout() {
        backgroundColor = .moreAccent
        layer.cornerRadius = 15
        
        snp.makeConstraints {
            $0.height.equalTo(260)
        }
        
        titleStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(30)
        }
        
        dayStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-30)
        }
        
        minLabel.snp.makeConstraints {
            $0.width.equalTo(30)
            $0.leading.equalToSuperview().offset(20)
        }
        
        maxLabel.snp.makeConstraints {
            $0.width.equalTo(30)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        temperatureBar.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(minLabel.snp.centerY)
        }
        
        [dateLabel, cityLabel, minLabel, maxLabel].forEach { $0.textColor = .accent }
        [minLabel, maxLabel].forEach { $0.textAlignment = .center }
        dateLabel.font = .boldSystemFont(ofSize: 28)
        cityLabel.font = .preferredFont(forTextStyle: .title2)
    }
    
    func thenLayout() {
        titleStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-10)
        }
        
        dayStackView.snp.makeConstraints {
            $0.centerY.equalTo(dateLabel.snp.centerY)
        }

        minLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-35)
        }
        
        maxLabel.snp.makeConstraints {
            $0.bottom.equalTo(minLabel.snp.bottom)
        }
    }
    
    func nowLayout() {
        titleStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(10)
        }
        
        dayStackView.snp.makeConstraints {
            $0.centerY.equalTo(cityLabel.snp.centerY)
        }
        
        minLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(35)
        }
        
        maxLabel.snp.makeConstraints {
            $0.top.equalTo(minLabel.snp.top)
        }
    }
    
    func bind(_ weather: ThenWeather?, isToday: Bool) {
        if isToday {
            dateLabel.text = "Now"
        } else {
            dateLabel.text = weather?.date.dateString ?? "-"
        }
        
        cityLabel.text = weather?.city ?? "-"
        minLabel.text = weather?.min.toString ?? "-"
        maxLabel.text = weather?.max.toString ?? "-"
        
        let morningStackView = momentStackView("9AM", temp: weather?.morning.toString ?? "-")
        let afternoonStackView = momentStackView("12PM", temp: weather?.afternoon.toString ?? "-")
        let eveningStackView = momentStackView("6PM", temp: weather?.evening.toString ?? "-")
        let nightStackView = momentStackView("12AM", temp: weather?.night.toString ?? "-")
     
        [morningStackView, afternoonStackView, eveningStackView, nightStackView].forEach { dayStackView.addArrangedSubview($0) }
    }
    
    func setOffset(leading: CGFloat, trailing: CGFloat) {
        temperatureBar.offset.send((leading: leading, trailing: trailing))
    }
}

#Preview {
    ComparisionViewController(weather: ThenWeather(date: Date(), city: "Suwon-si", min: 3, max: 48, morning: 19, afternoon: 30, evening: 26, night: -3))
}
