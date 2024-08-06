//
//  AppInfoViewController.swift
//  wotd_UIKit
//
//  Created by EMILY on 05/08/2024.
//

import UIKit

class AppInfoViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .descent
        
        tableView.register(CommonHeader.self, forHeaderFooterViewReuseIdentifier: CommonHeader.identifier)
        tableView.register(AppInfoCell.self, forCellReuseIdentifier: AppInfoCell.identifier)
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        addSubviews()
        layout()
    }
    
    private func setNavigationBar() {
        navigationItem.title = "wotd"
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

extension AppInfoViewController: SettingDelegate {
    func presentWebView() {
        let root = WebViewController()
        root.url = "https://github.com/emilyj4482"
        let vc = UINavigationController(rootViewController: root)
        present(vc, animated: true)
    }
}

extension AppInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        AppInfoSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = AppInfoSection(rawValue: section) else { return 0 }
        
        return section.cellTitles.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard
            let section = AppInfoSection(rawValue: section),
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
            let section = AppInfoSection(rawValue: indexPath.section),
            let cell = tableView.dequeueReusableCell(withIdentifier: AppInfoCell.identifier, for: indexPath) as? AppInfoCell
        else { return UITableViewCell() }
        
        switch section {
        case .app:
            cell.appSectionLayout()
            cell.bindTitle(section.cellTitles[indexPath.row])
        case .developer:
            cell.devSectionLayout()
            cell.bindImage(section.icons[indexPath.row])
            
            if indexPath.row == 2 {
                cell.githubCellLayout()
                cell.bindButtonTitle(section.cellTitles[indexPath.row])
            } else {
                cell.devCellLayout()
                cell.bindTitle(section.cellTitles[indexPath.row])
            }
        }

        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            170
        } else {
            45
        }
    }
}

#Preview {
    AppInfoViewController()
}
