//
//  AddWeatherViewController.swift
//  wotd_UIKit
//
//  Created by EMILY on 01/08/2024.
//

import UIKit
import SnapKit

final class AddWeatherViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        layout()
    }
    
    
    private func addSubviews() {
        
    }
    
    private func layout() {
        sheetPresentationController?.detents = [.custom(resolver: { _ in return 300 })]
        
        view.backgroundColor = .moreAccent
    }
}

#Preview {
    AddWeatherViewController()
}
