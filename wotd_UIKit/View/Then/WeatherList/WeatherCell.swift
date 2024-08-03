//
//  WeatherCell.swift
//  wotd_UIKit
//
//  Created by EMILY on 30/07/2024.
//

import UIKit
import SnapKit

class WeatherCell: UITableViewCell {
    
    static let identifier: String = "WeatherCell"

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .accent
        label.font = .boldSystemFont(ofSize: 22)
        
        return label
    }()
    
    private lazy var citynameLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .accent
        label.font = .preferredFont(forTextStyle: .title1)
        
        return label
    }()
    
    private lazy var arrowImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .accent
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        [dateLabel, citynameLabel, arrowImage].forEach { addSubview($0) }
    }
    
    private func layout() {
        backgroundColor = .descent
        selectionStyle = .none
        
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(20)
        }
        
        citynameLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(2)
            $0.leading.equalTo(dateLabel.snp.leading)
        }
        
        arrowImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.height.equalTo(20)
        }
    }
    
    func bind(weather: ThenWeather) {
        dateLabel.text = weather.date.dateString
        citynameLabel.text = weather.city
    }
}

#Preview {
    ThenViewController()
}
