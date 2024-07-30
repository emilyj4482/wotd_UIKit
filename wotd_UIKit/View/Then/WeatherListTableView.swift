//
//  WeatherListTableView.swift
//  wotd_UIKit
//
//  Created by EMILY on 30/07/2024.
//

import UIKit

final class WeatherListTableView: UITableView {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        delegate = self
        dataSource = self
        backgroundColor = .descent
        // register(UINib(nibName: WeatherCellKey.identifier, bundle: .main), forCellReuseIdentifier: WeatherCellKey.identifier)
        //register(nil, forCellReuseIdentifier: WeatherCellKey.identifier)
        
    }
}

extension WeatherListTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*
        guard let cell = dequeueReusableCell(withIdentifier: WeatherCellKey.identifier, for: indexPath) as? WeatherCell else { return UITableViewCell() }
        
        return cell
         */
        UITableViewCell()
    }
}

#Preview {
    ThenViewController()
}
