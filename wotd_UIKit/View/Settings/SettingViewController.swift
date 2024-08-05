//
//  SettingViewController.swift
//  wotd_UIKit
//
//  Created by EMILY on 20/07/2024.
//

import UIKit
import SnapKit

class SettingViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .descent
        tableView.register(SettingCell.self, forCellReuseIdentifier: SettingCell.identifier)
        tableView.register(SettingHeader.self, forHeaderFooterViewReuseIdentifier: SettingHeader.identifier)
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        addSubviews()
        layout()
        
    }
    
    private func setNavigationBar() {
        navigationItem.title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .descent
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.accent]
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.accent]
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func layout() {
        view.backgroundColor = .descent
        
        tableView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        SettingSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = SettingSection(rawValue: section) else { return 0 }
        
        switch section {
        case .info: return 3
        case .settings : return 1
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SettingHeader.identifier) as? SettingHeader,
        let section = SettingSection(rawValue: section)
        else { return UIView() }
        
        switch section {
        case .info:
            header.format("info")
        case .settings:
            header.format("settings")
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let section = SettingSection(rawValue: indexPath.section),
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.identifier, for: indexPath) as? SettingCell
        else { return UITableViewCell() }
        
        switch section {
        case .info:
            if indexPath.row == 0 {
                cell.firstCellLayout()
            } else {
                cell.normalCellLayout()
            }
            cell.bind(section.cellTitle[indexPath.row])
        case .settings:
            cell.normalCellLayout()
            cell.bind(section.cellTitle[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return 65
        } else {
            return 45
        }
    }
}

#Preview {
    SettingViewController()
}
