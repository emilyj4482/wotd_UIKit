//
//  AppearanceViewController.swift
//  wotd_UIKit
//
//  Created by EMILY on 05/08/2024.
//

import UIKit
import SnapKit

class AppearanceViewController: UIViewController {
    
    private func configStackView(_ emoji: String, _ mode: String) -> UIStackView {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .center
        stackView.backgroundColor = .moreAccent
        
        let emojiLabel = UILabel()
        
        emojiLabel.text = emoji
        emojiLabel.font = .preferredFont(forTextStyle: .largeTitle)
        
        let modeLabel = UILabel()
        
        modeLabel.text = "\(mode) Mode"
        
        [emojiLabel, modeLabel].forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }
    
    private lazy var systemModeStackView = configStackView("🌗", "System")
    
    private lazy var lightModeStackView = configStackView("🌝", "Light")
    
    private lazy var darkModeStackView = configStackView("🌚", "Dark")
    

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        layout()
    }
    
    private func addSubviews() {
        [systemModeStackView, lightModeStackView, darkModeStackView].forEach { view.addSubview($0) }
    }
    
    private func layout() {
        view.backgroundColor = .descent
        
        let offset: CGFloat = 20
        
        systemModeStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
        
        lightModeStackView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.top.equalTo(systemModeStackView.snp.bottom).offset(offset)
        }
        
        darkModeStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(lightModeStackView.snp.bottom).offset(offset)
        }
    }
}

#Preview {
    AppearanceViewController()
}
