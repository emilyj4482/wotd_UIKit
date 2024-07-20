//
//  WeatherRect.swift
//  wotd_UIKit
//
//  Created by EMILY on 21/07/2024.
//

import UIKit
import SnapKit

enum Day {
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
        case .today: 100
        case .notToday : 80
        }
    }
}

final class SmallWeatherRect: UIView {
    
    var day: Day
    var dayText: String
    var tempText: String

    init(day: Day, dayText: String, tempText: String) {
        self.day = day
        self.dayText = dayText
        self.tempText = tempText
        super.init(frame: CGRect())
        addSubviews()
        layout()
        setText(dayText: dayText, tempText: tempText)
        setLabel(day)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var dayLabel: UILabel = {
        let label: UILabel = UILabel()
        return label
    }()
    
    private var tempLabel: UILabel = {
        let label: UILabel = UILabel()
        return label
    }()
    
    private var maxminLabel: UILabel = {
        let label: UILabel = UILabel()
        return label
    }()
    
    private var weatherIcon: UIImageView = {
        let imageView: UIImageView = UIImageView()
        
        imageView.image = UIImage(systemName: "smoke.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .accent
        
        return imageView
    }()
    
    private var descriptionLabel: UILabel = {
        let label: UILabel = UILabel()
        return label
    }()
}

extension SmallWeatherRect {
    
    func addSubviews() {
        [dayLabel, tempLabel, maxminLabel, weatherIcon, descriptionLabel].forEach { addSubview($0) }
    }
    
    func setLabel(_ day: Day) {
        [dayLabel, tempLabel, maxminLabel, descriptionLabel].forEach { $0.textColor = .accent }
        dayLabel.font = .systemFont(ofSize: day.dayLabelFontSize, weight: .medium)
        tempLabel.font = .systemFont(ofSize: day.tempLabelFontSize, weight: .medium)
        maxminLabel.font = .preferredFont(forTextStyle: day.maxminLabelFontStyle)
        descriptionLabel.font = .preferredFont(forTextStyle: day.descriptionLabelFontStyle)
    }
    
    
    func setText(dayText: String, tempText: String) {
        dayLabel.text = dayText
        tempLabel.text = tempText
        maxminLabel.text = "max 30 min 23"
        descriptionLabel.text = "Overcast clouds"
    }
    
    func layout() {
        
        backgroundColor = .moreAccent
        layer.cornerRadius = 15
        snp.makeConstraints {
            $0.height.equalTo(day.rectHeight)
        }
        
        dayLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(day.offset)
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
            $0.width.height.equalTo(day.weatherIconSize)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.centerX.equalTo(weatherIcon.snp.centerX)
            $0.bottom.equalTo(maxminLabel.snp.bottom)
        }
    }
}

final class BigWeatherRect: UIView {
    
}

#Preview {
    NowViewController()
}
