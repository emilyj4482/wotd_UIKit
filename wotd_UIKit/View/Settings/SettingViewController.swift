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
        tableView.register(CommonHeader.self, forHeaderFooterViewReuseIdentifier: CommonHeader.identifier)
        
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
        
        return section.cellTitles.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard
            let section = SettingSection(rawValue: section),
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: CommonHeader.identifier) as? CommonHeader
        else { return UIView() }
        
        header.format(section.sectionTitle)
        
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
        
        if section == .info && indexPath.row == 0 {
            cell.firstCellLayout()
        } else {
            cell.normalCellLayout()
        }
        
        cell.bind(section.cellTitles[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            65
        } else {
            45
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = SettingSection(rawValue: indexPath.section) else { return }
        
        if section == .info && indexPath.row == 0 {
            return
        } else {
            navigationController?.pushViewController(section.viewControllers[indexPath.row], animated: true)
        }
    }
}

#Preview {
    SettingViewController()
}
