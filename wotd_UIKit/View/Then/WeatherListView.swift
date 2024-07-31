//
//  WeatherListView.swift
//  wotd_UIKit
//
//  Created by EMILY on 30/07/2024.
//

import UIKit
import SnapKit

final class WeatherListView: UIView {
    private var titleLabel: UILabel = {
        let label: UILabel = UILabel()
        
        label.text = "Weathers to compare"
        label.font = .boldSystemFont(ofSize: 32)
        label.textColor = .accent
        
        return label
    }()
    
    private var tableView = WeatherListTableView()
    
    private lazy var testButton: UIButton = {
        let button: UIButton = UIButton()
        
        let action = UIAction { [weak self] _ in
            print("TEST")
            self?.test()
        }
        
        button.setTitle("TEST", for: .normal)
        button.setTitleColor(.accent, for: .normal)
        button.addAction(action, for: .touchUpInside)
        
        return button
    }()
    
    var delegate: ThenViewDelegate?
    
    init() {
        super.init(frame: CGRect())
        
        
        
        addSubview()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func test() {
        delegate?.pushComparisionViewController(with: ThenViewModel.shared.weathers[0])
    }
    
    private func addSubview() {
        [titleLabel, testButton, tableView].forEach { addSubview($0) }
    }
    
    private func layout() {
        backgroundColor = .descent
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(testButton.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        testButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
    }
}

#Preview {
    ThenViewController()
}
