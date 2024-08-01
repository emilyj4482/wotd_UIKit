//
//  SearchResultCell.swift
//  wotd_UIKit
//
//  Created by EMILY on 02/08/2024.
//

import UIKit
import SnapKit

class SearchResultCell: UITableViewCell {
    
    static let identifier: String = "SearchResultCell"
    
    private lazy var citynameLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .accent
        label.font = .preferredFont(forTextStyle: .callout)
        label.numberOfLines = 0
        
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        layout()
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
    
    func bind(city: City) {
        citynameLabel.text = city.fullName
    }
}
