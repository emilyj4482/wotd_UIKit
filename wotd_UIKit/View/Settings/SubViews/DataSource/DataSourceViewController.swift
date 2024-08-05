//
//  DataSourceViewController.swift
//  wotd_UIKit
//
//  Created by EMILY on 05/08/2024.
//

import UIKit
import SnapKit

class DataSourceViewController: UIViewController {
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.alignment = .center
        
        return stackView
    }()
    
    private lazy var firstLabel: UILabel = {
        let label = UILabel()
        
        label.text = "This app's weather data comes from:"
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .accent
        
        return label
    }()
    
    private lazy var secondLabel: UILabel = {
        let label = UILabel()
        
        label.text = "OpenWeather API"
        label.font = .preferredFont(forTextStyle: .title1)
        label.textColor = .accent
        
        return label
    }()
    
    private lazy var urlButton: UIButton = {
        let button = UIButton()
        
        let action = UIAction { [weak self] _ in
            self?.presentWebView()
        }

        button.setTitle("openweathermap.org", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.secondaryLabel, for: .highlighted)
        button.addAction(action, for: .touchUpInside)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        layout()
    }
    
    private func addSubviews() {
        view.addSubview(labelStackView)
        [firstLabel, secondLabel, urlButton].forEach { labelStackView.addArrangedSubview($0) }
    }
    
    private func layout() {
        view.backgroundColor = .descent
        
        labelStackView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    private func presentWebView() {
        let root = WebViewController()
        root.url = "https://openweathermap.org"
        let vc = UINavigationController(rootViewController: root)
        present(vc, animated: true)
    }
}

#Preview {
    DataSourceViewController()
}
