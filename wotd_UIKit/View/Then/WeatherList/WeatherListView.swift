//
//  WeatherListView.swift
//  wotd_UIKit
//
//  Created by EMILY on 30/07/2024.
//

import UIKit
import SnapKit
import Combine

final class WeatherListView: UIView {
    
    private var vm = ThenViewModel.shared
    
    var delegate: ThenViewDelegate?
    
    private var subscriptions = Set<AnyCancellable>()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Weathers to compare"
        label.font = .boldSystemFont(ofSize: 32)
        label.textColor = .accent
        
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.backgroundColor = .descent
        tableView.register(WeatherCell.self, forCellReuseIdentifier: WeatherCell.identifier)
        
        return tableView
    }()
    
    init() {
        super.init(frame: .zero)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        addSubviews()
        layout()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        [titleLabel, tableView].forEach { addSubview($0) }
    }
    
    private func layout() {
        backgroundColor = .descent
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    private func bind() {
        vm.notiPublisher
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &subscriptions)
    }
    
    private func pushComparisionViewController(with weather: ThenWeather) {
        delegate?.pushComparisionViewController(with: weather)
    }
}

extension WeatherListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm.weathers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherCell.identifier, for: indexPath) as? WeatherCell else { return UITableViewCell() }
        
        let weather = vm.weathers[indexPath.row]
        cell.bind(weather: weather)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let weather = vm.weathers[indexPath.row]
        pushComparisionViewController(with: weather)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "") { [unowned self] _, _, completion in
            let weather = vm.weathers[indexPath.row]
            // action sheet 호출
            delegate?.showActionSheet(weather, index: indexPath.row)
            completion(true)
        }
        
        delete.image = UIImage(systemName: "trash")?.withTintColor(.descent, renderingMode: .alwaysOriginal)
        delete.backgroundColor = .accent
        
        let swipe = UISwipeActionsConfiguration(actions: [delete])
        
        return swipe
    }
}

#Preview {
    ThenViewController()
}
