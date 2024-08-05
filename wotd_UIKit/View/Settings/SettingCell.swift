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
    
    let version: String = "1.0.0"
    var isLatest: Bool = true
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .accent
        label.font = .systemFont(ofSize: 16, weight: .regular)
        
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        
        label.text = isLatest ? "\(version) is up to date" : "\(version) needs update"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 11, weight: .light)
        
        return label
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.spacing = 1
        
        return stackView
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
        commonLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonLayout() {
        backgroundColor = .moreAccent
        selectionStyle = .none
        
        addSubview(arrowImage)
        
        arrowImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.height.equalTo(15)
        }
    }
    
    func bind(_ title: String) {
        titleLabel.text = title
    }
    
    let offset: CGFloat = 20

    func firstCellLayout() {
        addSubview(labelStackView)
        [titleLabel, subtitleLabel].forEach { labelStackView.addArrangedSubview($0) }
        
        labelStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalTo(arrowImage.snp.leading).offset(-offset)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.bottom.equalToSuperview()
        }
    }
    
    func normalCellLayout() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalTo(arrowImage.snp.leading).offset(-offset)
        }
    }
}

#Preview {
    SettingViewController()
}
