//
//  ModeButtonView.swift
//  wotd_UIKit
//
//  Created by EMILY on 07/08/2024.
//

import UIKit
import SnapKit
import Combine

final class ModeButtonView: UIView {
    
    private let vm = SettingViewModel.shared
    
    private var subscriptions = Set<AnyCancellable>()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5
        
        return stackView
    }()
    
    private lazy var iconLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 40)
        
        return label
    }()
    
    private lazy var modeLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .accent
        
        return label
    }()
    
    private lazy var button = UIButton()
    
    init() {
        super.init(frame: .zero)
        addSubviews()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        [labelStackView, button].forEach { addSubview($0) }
        [iconLabel, modeLabel].forEach { labelStackView.addArrangedSubview($0)}
    }
    
    private func layout() {
        backgroundColor = .moreAccent
        layer.cornerRadius = 15
        
        snp.makeConstraints {
            $0.width.equalTo(130)
            $0.height.equalTo(110)
        }
        
        labelStackView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        
        iconLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
        
        modeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
        
        button.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
    }
    
    func bind(_ type: AppearanceType) {
        iconLabel.text = type.icon
        modeLabel.text = "\(type.modeName) Mode"
        
        let action = UIAction { [weak self] _ in
            self?.vm.changeAppearance(type)
            self?.window?.overrideUserInterfaceStyle = type.colorScheme
        }
        button.addAction(action, for: .touchUpInside)

        vm.$appearance
            .map { return $0.rawValue == type.rawValue }
            .sink {
                if $0 {
                    self.backgroundColor = .mostAccent
                } else {
                    self.backgroundColor = .moreAccent
                }
            }
            .store(in: &subscriptions)
    }
}

#Preview {
    AppearanceViewController()
}
