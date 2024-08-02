//
//  SearchResultCell.swift
//  wotd_UIKit
//
//  Created by EMILY on 02/08/2024.
//

import UIKit
import SnapKit
import Combine

class SearchResultCell: UITableViewCell {
    
    static let identifier: String = "SearchResultCell"
    
    private let vm = AddViewModel.shared
    
    private var subscriptions = Set<AnyCancellable>()
    
    private lazy var citynameLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .accent
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = 0
        
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        layout()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(citynameLabel)
        backgroundColor = .addSheet
    }
    
    private func layout() {
        selectionStyle = .none
        
        citynameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    func setCityName(city: City) {
        citynameLabel.text = city.fullName
    }
    
    private func bind() {
        vm.$isCitySelected
            .sink { [self] in
                if $0 == true {
                    citynameLabel.font = .boldSystemFont(ofSize: 17)
                } else {
                    citynameLabel.font = .systemFont(ofSize: 17)
                }
            }
            .store(in: &subscriptions)

    }
}

#Preview {
    AddWeatherViewController()
}
