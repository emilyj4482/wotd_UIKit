//
//  WeatherCell.swift
//  wotd_UIKit
//
//  Created by EMILY on 30/07/2024.
//

import UIKit

enum WeatherCellKey {
    static let identifier: String = "WeatherCell"
}

class WeatherCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String? = WeatherCellKey.identifier) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
