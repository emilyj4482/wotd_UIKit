//
//  CommonHeader.swift
//  wotd_UIKit
//
//  Created by EMILY on 05/08/2024.
//

import UIKit
import SnapKit

class CommonHeader: UITableViewHeaderFooterView {
    static let identifier: String = "CommonHeader"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .boldSystemFont(ofSize: 13)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    func format(_ title: String) {
        backgroundColor = .descent
        contentView.backgroundColor = .descent
        
        addSubview(titleLabel)
        
        titleLabel.text = title.uppercased()
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(30)
        }
    }
}
