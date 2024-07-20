//
//  NowViewController.swift
//  wotd_UIKit
//
//  Created by EMILY on 20/07/2024.
//

import UIKit
import SnapKit

final class NowViewController: UIViewController {
    
    private var containerView: UIView = {
        let view: UIView = UIView()
        
        return view
    }()
    
    private var locationHStack: UIStackView = {
        let hStack: UIStackView = UIStackView()
        
        hStack.axis = .horizontal
        hStack.spacing = 8
        
        return hStack
        
    }()
    
    private var locationImage: UIImageView = {
        let imageView: UIImageView = UIImageView()
        
        imageView.image = UIImage(systemName: "location.fill")
        imageView.tintColor = .accent
    
        return imageView
    }()
    
    private var loacationText: UILabel = {
        let label: UILabel = UILabel()
        
        label.text = NowViewModel.shared.location
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .accent
        
        return label
    }()
    
    private var weatherRectVStack: UIStackView = {
        let vStack: UIStackView = UIStackView()
        
        vStack.axis = .vertical
        vStack.spacing = 13
        
        return vStack
        
    }()
    
    private var yesterdayRect = SmallWeatherRect(day: .notToday, dayText: "Yesterday", tempText: "30.0")
    
    private var nowRect = SmallWeatherRect(day: .today, dayText: "Now", tempText: "27.0")
    
    private var tomorrowRect = SmallWeatherRect(day: .notToday, dayText: "Tomorrow", tempText: "23.6")


    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        layout()
    }

    
    private func addSubviews() {
        view.addSubview(containerView)
        
        containerView.addSubview(locationHStack)
        containerView.addSubview(weatherRectVStack)
        
        locationHStack.addArrangedSubview(locationImage)
        locationHStack.addArrangedSubview(loacationText)
        
        weatherRectVStack.addArrangedSubview(yesterdayRect)
        weatherRectVStack.addArrangedSubview(nowRect)
        weatherRectVStack.addArrangedSubview(tomorrowRect)
    }
    
    
    private func layout() {
        containerView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        locationHStack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        locationImage.snp.makeConstraints {
            $0.width.height.equalTo(30)
        }
        
        weatherRectVStack.snp.makeConstraints {
            $0.top.equalTo(locationHStack.snp.bottom).offset(20)
            $0.leading.equalTo(locationHStack.snp.leading)
            $0.trailing.equalTo(locationHStack.snp.trailing)
        }
        
        
    }
}

#Preview {
    NowViewController()
}
