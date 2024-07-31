//
//  WeatherListView.swift
//  wotd_UIKit
//
//  Created by EMILY on 30/07/2024.
//

import UIKit
import SnapKit

final class WeatherListView: UIView {
    
    private var vm = ThenViewModel.shared
    
    private var titleLabel: UILabel = {
        let label: UILabel = UILabel()
        
        label.text = "Weathers to compare"
        label.font = .boldSystemFont(ofSize: 32)
        label.textColor = .accent
        
        return label
    }()
    
    private var tableView: UITableView = {
        let tableView: UITableView = UITableView()
        
        tableView.backgroundColor = .descent
        tableView.register(WeatherCell.self, forCellReuseIdentifier: WeatherCell.identifier)
        
        return tableView
    }()
    /*
    private lazy var testButton: UIButton = {
        let button: UIButton = UIButton()
        
        let action = UIAction { [weak self] _ in
            print("TEST")
            self?.test()
        }
        
        button.setTitle("TEST", for: .normal)
        button.setTitleColor(.accent, for: .normal)
        button.addAction(action, for: .touchUpInside)
        
        return button
    }()
    */
    var delegate: ThenViewDelegate?
    
    init() {
        super.init(frame: CGRect())
        
        tableView.delegate = self
        tableView.dataSource = self
        
        addSubview()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func test() {
        delegate?.pushComparisionViewController(with: ThenViewModel.shared.weathers[0])
    }
    
    private func addSubview() {
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
        /*
        testButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
         */
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
        print(weather)
        test()
        
    }
}

#Preview {
    ThenViewController()
}
