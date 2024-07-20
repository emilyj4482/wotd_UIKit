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
    
    private var weatherRectVStack: UIStackView = {
        let vStack: UIStackView = UIStackView()
        
        vStack.axis = .vertical
        
        return vStack
        
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
    
    private var yesterdayRect = SmallWeatherRect(dayText: "Yesterday", tempText: "30.0")


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
    }
    
    
    private func layout() {
        containerView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
        
        locationHStack.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        locationImage.snp.makeConstraints {
            $0.width.height.equalTo(30)
        }
        
        weatherRectVStack.snp.makeConstraints {
            $0.top.equalTo(locationHStack.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        
    }
}

#Preview {
    NowViewController()
}
