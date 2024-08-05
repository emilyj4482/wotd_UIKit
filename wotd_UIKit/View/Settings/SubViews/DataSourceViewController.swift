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
        
        return label
    }()
    
    private lazy var secondLabel: UILabel = {
        let label = UILabel()
        
        label.text = "OpenWeather API"
        label.font = .preferredFont(forTextStyle: .title1)
        
        return label
    }()
    
    private lazy var urlLabel: UILabel = {
        let label = UILabel()
        
        label.text = "openweathermap.org"
        label.font = .preferredFont(forTextStyle: .callout)
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        layout()
    }
    
    private func addSubviews() {
        view.addSubview(labelStackView)
        [firstLabel, secondLabel, urlLabel].forEach { labelStackView.addArrangedSubview($0) }
    }
    
    private func layout() {
        view.backgroundColor = .descent
        
        [firstLabel, secondLabel, urlLabel].forEach { $0.textColor = .accent }
        
        labelStackView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}

#Preview {
    DataSourceViewController()
}
