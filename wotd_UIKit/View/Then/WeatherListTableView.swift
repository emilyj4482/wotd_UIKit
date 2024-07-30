//
//  WeatherListTableView.swift
//  wotd_UIKit
//
//  Created by EMILY on 30/07/2024.
//

import UIKit

final class WeatherListTableView: UITableView {
    
    private var vm = ThenViewModel.shared

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
        register(WeatherCell.self, forCellReuseIdentifier: WeatherCell.identifier)
    }
}

extension WeatherListTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm.weathers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: WeatherCell.identifier, for: indexPath) as? WeatherCell else { return UITableViewCell() }
        
        let weather = vm.weathers[indexPath.row]
        cell.bind(weather: weather)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}

#Preview {
    ThenViewController()
}
