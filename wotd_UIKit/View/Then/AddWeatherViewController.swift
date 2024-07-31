//
//  AddWeatherViewController.swift
//  wotd_UIKit
//
//  Created by EMILY on 01/08/2024.
//

import UIKit
import SnapKit

final class AddWeatherViewController: UIViewController {
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Date"
        
        return label
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        
        label.text = "City"
        
        return label
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        
        let action = UIAction { [weak self] _ in
            self?.dismiss(animated: true)
        }

        button.configuration = .filled()
        button.configuration?.title = "Add"
        button.configuration?.cornerStyle = .capsule
        button.configuration?.baseForegroundColor = .descent
        button.configuration?.baseBackgroundColor = .accent
        
        button.addAction(action, for: .touchUpInside)
        
        return button
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        layout()
    }
    
    
    private func addSubviews() {
        [dateLabel, cityLabel, addButton].forEach { view.addSubview($0) }
    }
    
    private func layout() {
        sheetPresentationController?.detents = [.custom(resolver: { _ in return 300 })]
        view.backgroundColor = .addSheet
        
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().offset(20)
        }
        
        cityLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(30)
            $0.leading.equalTo(dateLabel.snp.leading)
        }
        
        addButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-50)
            $0.width.equalTo(100)
            $0.height.equalTo(50)
        }
    }
}

#Preview {
    ThenViewController()
}
