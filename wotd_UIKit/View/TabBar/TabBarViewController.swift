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
    
    // comparision view에서 temperature bar의 width를 정의하기 위해 현재 view의 width 값을 할당해둔다.
    func setCGFloat() {
        SettingViewModel.shared.frameWidth = view.frame.width
    }
}

#Preview {
    TabBarViewController()
}
