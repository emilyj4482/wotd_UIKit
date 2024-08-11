//
//  TabBarViewController.swift
//  wotd_UIKit
//
//  Created by EMILY on 21/07/2024.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    private var locationManager = LocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabBarViewControllers: [UIViewController] = TabBarItem.allCases
            .map { tab in
                let viewController = tab.viewController
                viewController.tabBarItem = UITabBarItem(title: tab.title, image: tab.icon, selectedImage: tab.icon)
                return viewController
            }
        
        self.viewControllers = tabBarViewControllers
        
        setCGFloat()
    }
    
    // comparision view > temperature bar의 width : 화면 width - ((rect과의 간격 20 - 온도 label과의 간격 20 - 온도 label width 30 - 온도 label과 bar의 거리 10) * 2)
    func setCGFloat() {
        ThenViewModel.shared.tempBarWidth = view.frame.width - 160
    }
}

#Preview {
    TabBarViewController()
}
