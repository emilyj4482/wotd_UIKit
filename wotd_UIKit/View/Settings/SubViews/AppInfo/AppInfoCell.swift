//
//  AppInfoCell.swift
//  wotd_UIKit
//
//  Created by EMILY on 06/08/2024.
//

import UIKit
import SnapKit

class AppInfoCell: UITableViewCell {
    static let identifier: String = "AppInfoCell"
    
    var delegate: SettingDelegate?
    
    private lazy var wotdStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.alignment = .leading
        
        return stackView
    }()
    
    private lazy var developerStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.spacing = 10
        
        return stackView
    }()
    
    private lazy var titleLabel = UILabel()
    
    private lazy var iconView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .accent
        
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.text = """
        wotd is short for Weather Of The Day.\nIt started from the idea that how I want to compare today's weather to specific day's weather I remember whether it's colder or hotter.
        """
        label.font = .preferredFont(forTextStyle: .subheadline)
        
        return label
    }()
    
    private lazy var urlButton: UIButton = {
        let button = UIButton()
        
        let action = UIAction { [weak self] _ in
            self?.presentWebView()
        }
        
        button.setTitleColor(.accent, for: .normal)
        button.setTitleColor(.systemBlue, for: .highlighted)
        button.addAction(action, for: .touchUpInside)
        
        return button
    }()
    
    let offset: CGFloat = 20
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func presentWebView() {
        delegate?.presentWebView()
    }
    
    private func commonLayout() {
        backgroundColor = .moreAccent
        selectionStyle = .none
        titleLabel.textColor = .accent
    }
    
    func appSectionLayout() {
        addSubview(wotdStackView)
        [titleLabel, descriptionLabel].forEach { wotdStackView.addArrangedSubview($0) }
        
        wotdStackView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.top.leading.equalToSuperview().offset(offset)
            $0.bottom.trailing.equalToSuperview().offset(-offset)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(120)
        }
        
        titleLabel.font = .boldSystemFont(ofSize: 18)
    }
    
    func devSectionLayout() {
        contentView.addSubview(developerStackView)
        
        developerStackView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
            $0.height.equalTo(35)
        }
    }
    
    func devCellLayout() {
        [iconView, titleLabel].forEach { developerStackView.addArrangedSubview($0) }
        
        iconView.snp.makeConstraints {
            $0.centerY.leading.equalToSuperview()
            $0.width.height.equalTo(25)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
        }
        
        titleLabel.font = .preferredFont(forTextStyle: .callout)
    }
    
    func githubCellLayout() {
        [iconView, urlButton].forEach { developerStackView.addArrangedSubview($0) }
        
        iconView.snp.makeConstraints {
            $0.centerY.leading.equalToSuperview()
            $0.width.height.equalTo(25)
        }
        
        urlButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
        }
        
        urlButton.titleLabel?.snp.makeConstraints({
            $0.leading.equalToSuperview()
        })
        
        urlButton.titleLabel?.font = .preferredFont(forTextStyle: .callout)
    }
    
    func bindTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func bindButtonTitle(_ title: String) {
        urlButton.setTitle(title, for: .normal)
    }
    
    func bindImage(_ image: UIImage?) {
        guard let image = image else { return }
        iconView.image = image
    }
    
}

#Preview {
    AppInfoViewController()
}
