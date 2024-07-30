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
    
    private var addButton: UIButton = {
        let button: UIButton = UIButton()
        
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.tintColor = .accent
        button.imageView?.contentMode = .scaleAspectFit
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews(vm.isEmpty ? emptyView : weatherListView)
        layout(vm.isEmpty ? emptyView : weatherListView)
    }
    
    private func addSubviews(_ subview: UIView) {
        [subview, addButton].forEach { view.addSubview($0) }
    }
    
    private func layout(_ subview: UIView) {
        subview.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        addButton.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview().offset(-130)
            $0.width.height.equalTo(65)
        }
        
        addButton.imageView?.snp.makeConstraints {
            $0.width.height.equalTo(65)
        }
    }
}

#Preview {
    ThenViewController()
}
