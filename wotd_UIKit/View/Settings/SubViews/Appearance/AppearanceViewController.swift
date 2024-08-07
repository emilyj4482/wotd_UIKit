//
//  AppearanceViewController.swift
//  wotd_UIKit
//
//  Created by EMILY on 05/08/2024.
//

import UIKit
import SnapKit

class AppearanceViewController: UIViewController {
   
    private lazy var systemButton = ModeButtonView()
    
    private lazy var lightButton = ModeButtonView()
    
    private lazy var darkButton = ModeButtonView()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        layout()
        bind()
    }
    
    private func addSubviews() {
        [systemButton, lightButton, darkButton].forEach { view.addSubview($0) }
    }
    
    private func layout() {
        view.backgroundColor = .descent
        
        let offset: CGFloat = 30
        
        systemButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(lightButton.snp.top).offset(-offset)
        }
        
        lightButton.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            
        }
        
        darkButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(lightButton.snp.bottom).offset(offset)
        }
    }
    
    private func bind() {
        systemButton.bind(AppearanceType.system)
        lightButton.bind(AppearanceType.light)
        darkButton.bind(AppearanceType.dark)
    }
}

#Preview {
    AppearanceViewController()
}
