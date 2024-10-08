//
//  NowViewController.swift
//  wotd_UIKit
//
//  Created by EMILY on 20/07/2024.
//

import UIKit
import SnapKit
import Combine

final class NowViewController: UIViewController {
    
    private var vm = NowViewModel.shared
    private var subscriptions = Set<AnyCancellable>()
    
    private var containerView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private var locationHStack: UIStackView = {
        let hStack = UIStackView()
        
        hStack.axis = .horizontal
        hStack.spacing = 8
        
        return hStack
        
    }()
    
    private var locationImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(systemName: "location.fill")
        imageView.tintColor = .accent
    
        return imageView
    }()
    
    private var locationText: UILabel = {
        let label = UILabel()
        
        label.text = "-"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .accent
        
        return label
    }()
    
    private var weatherRectVStack: UIStackView = {
        let vStack = UIStackView()
        
        vStack.axis = .vertical
        vStack.spacing = 13
        
        return vStack
        
    }()
    
    private var yesterdayRect = WeatherRect(day: Day.yesterday)
    private var nowRect = WeatherRect(day: Day.today)
    private var tomorrowRect = WeatherRect(day: Day.tomorrow)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        layout()
        bind()
    }
}

extension NowViewController {
    private func addSubviews() {
        view.addSubview(containerView)
        
        containerView.addSubview(locationHStack)
        containerView.addSubview(weatherRectVStack)
        
        locationHStack.addArrangedSubview(locationImage)
        locationHStack.addArrangedSubview(locationText)
        
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
            $0.width.height.equalTo(35)
        }
        
        weatherRectVStack.snp.makeConstraints {
            $0.top.equalTo(locationHStack.snp.bottom).offset(20)
            $0.leading.equalTo(locationHStack.snp.leading)
            $0.trailing.equalTo(locationHStack.snp.trailing)
        }
    }
    
    private func bind() {
        vm.location
            .receive(on: DispatchQueue.main)
            .sink { location in
                self.locationText.text = location
            }
            .store(in: &subscriptions)
    }
}

#Preview {
    NowViewController()
}
