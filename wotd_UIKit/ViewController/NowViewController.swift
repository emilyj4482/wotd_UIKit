//
//  NowViewController.swift
//  wotd_UIKit
//
//  Created by EMILY on 20/07/2024.
//

import UIKit
import SnapKit

class NowViewController: UIViewController {
    
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
    
        return imageView
    }()
    
    private var loacationText: UILabel = {
        let label: UILabel = UILabel()
        
        label.text = NowViewModel.shared.location
        label.font = .systemFont(ofSize: 30, weight: .bold)
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        layout()
    }

    
    func addSubviews() {
        view.addSubview(containerView)
        
        containerView.addSubview(locationHStack)
        containerView.addSubview(weatherRectVStack)
        
        locationHStack.addArrangedSubview(locationImage)
        locationHStack.addArrangedSubview(loacationText)
    }
    
    
    func layout() {
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
        
        locationHStack.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        locationImage.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        weatherRectVStack.snp.makeConstraints { make in
            make.top.equalTo(locationHStack.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

#Preview {
    NowViewController()
}
