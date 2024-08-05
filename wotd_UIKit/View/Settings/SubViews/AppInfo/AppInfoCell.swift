//
//  AppInfoCell.swift
//  wotd_UIKit
//
//  Created by EMILY on 06/08/2024.
//

import UIKit

class AppInfoCell: UITableViewCell {
    static let identifier: String = "AppInfoCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        backgroundColor = .moreAccent
        selectionStyle = .none
    }
}
