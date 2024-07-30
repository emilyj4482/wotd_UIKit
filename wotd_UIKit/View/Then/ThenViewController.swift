//
//  ThenViewController.swift
//  wotd_UIKit
//
//  Created by EMILY on 20/07/2024.
//

import UIKit
import SnapKit

class ThenViewController: UIViewController {
    
    private var vm = ThenViewModel.shared
    
    private var emptyView = EmptyView()
    
    private var weatherListView = WeatherListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews(vm.isEmpty ? emptyView : weatherListView)
        layout(vm.isEmpty ? emptyView : weatherListView)
    }
    
    private func addSubviews(_ subview: UIView) {
        view.addSubview(subview)
    }
    
    private func layout(_ subview: UIView) {
        subview.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

#Preview {
    ThenViewController()
}
