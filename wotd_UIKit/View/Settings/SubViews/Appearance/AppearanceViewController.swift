//
//  AppearanceViewController.swift
//  wotd_UIKit
//
//  Created by EMILY on 05/08/2024.
//

import UIKit
import SnapKit

class AppearanceViewController: UIViewController {
    
    private lazy var testButton = ModeButtonView()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        layout()
        bind()
    }
    
    private func addSubviews() {
        view.addSubview(testButton)
    }
    
    private func layout() {
        view.backgroundColor = .descent
        
        testButton.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            
        }
    }
    
    private func bind() {
        testButton.bind(emoji: "🌗", mode: "System")
    }
}

#Preview {
    AppearanceViewController()
}
