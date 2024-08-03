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
        let tableView = UITableView()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .accent
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        layout()
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func layout() {
        view.backgroundColor = .descent
        
        tableView.snp.makeConstraints {
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
    
    
}

#Preview {
    SettingViewController()
}
