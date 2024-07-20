//
//  WeatherRect.swift
//  wotd_UIKit
//
//  Created by EMILY on 21/07/2024.
//

import UIKit
import SnapKit

final class SmallWeatherRect: UIView {
    
    var dayText: String
    var tempText: String

    init(dayText: String, tempText: String) {
        self.dayText = dayText
        self.tempText = tempText
        super.init(frame: CGRect())
        addSubviews()
        layout()
        setText(dayText: "Yesterday", tempText: "26.0")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var dayLabel: UILabel = {
        let label: UILabel = UILabel()
        
        //label.font = .preferredFont(forTextStyle: .title1)
        label.font = .systemFont(ofSize: 23, weight: .medium)
        label.textColor = .accent
        
        return label
    }()
    
    private var tempLabel: UILabel = {
        let label: UILabel = UILabel()
        
        label.font = .systemFont(ofSize: 50, weight: .medium)
        label.textColor = .accent
        
        return label
    }()
    
    private var maxminLabel: UILabel = {
        let label: UILabel = UILabel()
        
        label.text = "max 30 min 23"
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .accent
        
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
        
        label.text = "Overcast clouds"
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textColor = .accent
        
        return label
    }()
}

extension SmallWeatherRect {
    
    func addSubviews() {
        [dayLabel, tempLabel, maxminLabel, weatherIcon, descriptionLabel].forEach { addSubview($0) }
    }
    
    
    func setText(dayText: String, tempText: String) {
        dayLabel.text = dayText
        tempLabel.text = tempText
    }
    
    func layout() {
        
        backgroundColor = .cyan
        layer.cornerRadius = 15
        snp.makeConstraints {
            $0.height.equalTo(180)
        }
        
        dayLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().offset(20)
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
            $0.width.height.equalTo(80)
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
    SmallWeatherRect(dayText: "Yesterday", tempText: "26.0")
}
