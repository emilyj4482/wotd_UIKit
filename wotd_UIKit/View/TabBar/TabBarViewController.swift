//
//  TabBarViewController.swift
//  wotd_UIKit
//
//  Created by EMILY on 21/07/2024.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    private var lm = LocationManager.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabBarViewControllers: [UIViewController] = TabBarItem.allCases
            .map { tab in
                let viewController = tab.viewController
                viewController.tabBarItem = UITabBarItem(title: tab.title, image: tab.icon, selectedImage: tab.icon)
                return viewController
            }
        
        self.viewControllers = tabBarViewControllers
        
        
        
        // NowViewModel.shared.apiTest()
        // NowViewModel.shared.printWeather()
    }
}
