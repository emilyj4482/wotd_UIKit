//
//  ComparisionViewController.swift
//  wotd_UIKit
//
//  Created by EMILY on 31/07/2024.
//

import UIKit
import SnapKit

final class ComparisionViewController: UIViewController {
    
    let weather: ThenWeather
    
    private lazy var dateLabel: UILabel = {
        let label: UILabel = UILabel()
        
        label.textColor = .descent
        label.font = .preferredFont(forTextStyle: .largeTitle)
        
        return label
    }()
    
    private lazy var tempLabel: UILabel = {
        let label: UILabel = UILabel()
        
        label.textColor = .descent
        label.font = .preferredFont(forTextStyle: .title1)
        
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
        view.backgroundColor = .accent
        
        addSubviews()
        layout()
        bind()
    }
    
    private func addSubviews() {
        [dateLabel, tempLabel].forEach { view.addSubview($0) }
    }
    
    private func layout() {
        dateLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        tempLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(dateLabel.snp.bottom).offset(20)
        }
    }
    
    func bind() {
        dateLabel.text = weather.date.dateString
        tempLabel.text = weather.afternoon.toString
    }
}

#Preview {
    ComparisionViewController(weather: ThenViewModel.shared.weathers[0])
}
