//
//  WeatherRect.swift
//  wotd_UIKit
//
//  Created by EMILY on 21/07/2024.
//

import UIKit
import SnapKit

// 현재 날씨 rect와 어제, 내일 날씨 rect의 size가 다르기 때문에 분기한다.
enum IsToday {
    case today
    case notToday
    
    var rectHeight: UInt {
        switch self {
        case .today: 220
        case .notToday: 180
        }
    }
    
    var offset: UInt {
        switch self {
        case .today: 38
        case .notToday : 32
        }
    }
    
    var dayLabelFontSize: CGFloat {
        switch self {
        case .today: 30
        case .notToday: 23
        }
    }
    
    var tempLabelFontSize: CGFloat {
        switch self {
        case .today: 60
        case .notToday: 50
        }
    }
    
    var maxminLabelFontStyle: UIFont.TextStyle {
        switch self {
        case .today: .body
        case .notToday: .subheadline
        }
    }
    
    var descriptionLabelFontStyle: UIFont.TextStyle {
        switch self {
        case .today: .subheadline
        case .notToday: .caption1
        }
    }
    
    var weatherIconSize: UInt {
        switch self {
        case .today: 90
        case .notToday : 70
        }
    }
}

final class WeatherRect: UIView {
    
    var day: ThreeDays
     
    init(day: ThreeDays) {
        self.day = day
        super.init(frame: CGRect())
        addSubviews()
        layout()
        setInfo(day)
        setLabel(day)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var dayLabel = UILabel()
    
    private var tempLabel = UILabel()
    
    private var maxminLabel = UILabel()
    
    private var weatherIcon: UIImageView = {
        let imageView: UIImageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .accent
        
        return imageView
    }()
    
    private var descriptionLabel = UILabel()
}

extension WeatherRect {
    
    func addSubviews() {
        [dayLabel, tempLabel, maxminLabel, weatherIcon, descriptionLabel].forEach { addSubview($0) }
    }
    
    func setLabel(_ day: ThreeDays) {
        [dayLabel, tempLabel, maxminLabel, descriptionLabel].forEach { $0.textColor = .accent }
        dayLabel.font = .systemFont(ofSize: day.isToday.dayLabelFontSize, weight: .medium)
        tempLabel.font = .systemFont(ofSize: day.isToday.tempLabelFontSize, weight: .medium)
        maxminLabel.font = .preferredFont(forTextStyle: day.isToday.maxminLabelFontStyle)
        descriptionLabel.font = .preferredFont(forTextStyle: day.isToday.descriptionLabelFontStyle)
    }
    
    func setInfo(_ day: ThreeDays) {
        dayLabel.text = day.title
        tempLabel.text = day.weather?.nowTemp.toString ?? "-"
        maxminLabel.text = "max \(day.weather?.maxTemp.toString ?? "-") min \(day.weather?.minTemp.toString ?? "-")"
        descriptionLabel.text = day.weather?.description ?? ""
        weatherIcon.image = UIImage(systemName: day.weather?.icon ?? "cloud.fill")
    }
    
    func layout() {
        backgroundColor = .moreAccent
        layer.cornerRadius = 15
        
        snp.makeConstraints {
            $0.height.equalTo(day.isToday.rectHeight)
        }
        
        dayLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(day.isToday.offset)
            $0.leading.equalToSuperview().offset(30)
        }
        
        tempLabel.snp.makeConstraints {
            $0.top.equalTo(dayLabel.snp.bottom).offset(3)
            $0.leading.equalTo(dayLabel.snp.leading)
        }
        
        maxminLabel.snp.makeConstraints {
            $0.top.equalTo(tempLabel.snp.bottom).offset(3)
            $0.leading.equalTo(tempLabel.snp.leading)
        }
        
        weatherIcon.snp.makeConstraints {
            $0.top.equalTo(dayLabel.snp.top)
            $0.trailing.equalToSuperview().inset(60)
            $0.width.height.equalTo(day.isToday.weatherIconSize)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.centerX.equalTo(weatherIcon.snp.centerX)
            $0.bottom.equalTo(maxminLabel.snp.bottom)
        }
    }
}

#Preview {
    NowViewController()
}
