//
//  WeatherRect.swift
//  wotd_UIKit
//
//  Created by EMILY on 21/07/2024.
//

import UIKit
import SnapKit
import Combine

final class WeatherRect: UIView {
    
    private var vm = NowViewModel.shared
    private var subscriptions = Set<AnyCancellable>()
    
    let day: Day
     
    init(day: Day) {
        self.day = day
        super.init(frame: CGRect())
        addSubviews()
        layout()
        setInfo(day)
        setLabel(day)
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var dayLabel = UILabel()
    
    private var tempLabel: UILabel = {
        let label = UILabel()
        
        label.text = "-"
        
        return label
    }()
    
    private var maxminLabel: UILabel = {
        let label = UILabel()
        
        label.text = "max - min -"
        
        return label
    }()
    
    private var weatherIcon: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .accent
        imageView.image = UIImage(systemName: "cloud.fill")
        
        return imageView
    }()
    
    private var descriptionLabel = UILabel()
}

extension WeatherRect {
    private func addSubviews() {
        [dayLabel, tempLabel, maxminLabel, weatherIcon, descriptionLabel].forEach { addSubview($0) }
    }
    
    private func setLabel(_ day: Day) {
        [dayLabel, tempLabel, maxminLabel, descriptionLabel].forEach { $0.textColor = .accent }
        dayLabel.font = .systemFont(ofSize: day.isToday.dayLabelFontSize, weight: .medium)
        tempLabel.font = .systemFont(ofSize: day.isToday.tempLabelFontSize, weight: .medium)
        maxminLabel.font = .preferredFont(forTextStyle: day.isToday.maxminLabelFontStyle)
        descriptionLabel.font = .preferredFont(forTextStyle: day.isToday.descriptionLabelFontStyle)
    }
    
    private func setInfo(_ day: Day) {
        dayLabel.text = day.title
    }
    
    private func layout() {
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
    
    private func getDay(_ day: Day) -> CurrentValueSubject<ThreeDays, Never> {
        switch day {
        case .yesterday: vm.yesterday
        case .today: vm.today
        case .tomorrow: vm.tomorrow
        }
    }
    
    private func bind() {
        getDay(day)
            .receive(on: DispatchQueue.main)
            .map { $0.weather }
            .sink { [weak self] weather in
                guard let weather = weather else { return }
                self?.tempLabel.text = weather.nowTemp.toString
                self?.maxminLabel.text = "max \(weather.maxTemp.toString) min \(weather.minTemp.toString)"
                self?.descriptionLabel.text = weather.description
                self?.weatherIcon.image = UIImage(systemName: weather.icon)
            }
            .store(in: &subscriptions)
    }
}

#Preview {
    NowViewController()
}
