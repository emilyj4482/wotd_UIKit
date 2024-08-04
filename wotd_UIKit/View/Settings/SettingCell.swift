//
//  SettingCell.swift
//  wotd_UIKit
//
//  Created by EMILY on 04/08/2024.
//

import UIKit
import SnapKit

class SettingCell: UITableViewCell {
    static let identifier: String = "SettingCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .accent
        label.font = .systemFont(ofSize: 16, weight: .regular)
        
        return label
    }()
    
    private lazy var arrowImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .accent
        imageView.contentMode = .scaleAspectFit
        
        return imageView
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
        [titleLabel, arrowImage].forEach { addSubview($0) }
    }
    
    private func layout() {
        backgroundColor = .moreAccent
        selectionStyle = .none
        
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(arrowImage.snp.leading).offset(-20)
        }
        
        arrowImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.height.equalTo(15)
        }
    }
    
    func bind(_ title: String) {
        titleLabel.text = title
    }
}

#Preview {
    SettingViewController()
}
