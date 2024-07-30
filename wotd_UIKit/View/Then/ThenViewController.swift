//
//  ThenViewController.swift
//  wotd_UIKit
//
//  Created by EMILY on 20/07/2024.
//

import UIKit

class ThenViewController: UIViewController {
    
    private var emptyView = EmptyView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        layout()
    }
    
    private func addSubviews() {
        view.addSubview(emptyView)
    }
    
    private func layout() {
        emptyView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

#Preview {
    ThenViewController()
}
