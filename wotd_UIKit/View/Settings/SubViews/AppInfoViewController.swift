//
//  AppInfoViewController.swift
//  wotd_UIKit
//
//  Created by EMILY on 05/08/2024.
//

import UIKit

class AppInfoViewController: UIViewController {

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
        
    }
    
    private func layout() {
        view.backgroundColor = .descent
    }
}

#Preview {
    AppInfoViewController()
}
