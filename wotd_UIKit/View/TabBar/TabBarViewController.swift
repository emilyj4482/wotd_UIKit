//
//  TabBarViewController.swift
//  wotd_UIKit
//
//  Created by EMILY on 21/07/2024.
//

import UIKit
import Combine

final class TabBarViewController: UITabBarController {
    
    private var locationManager = LocationManager()
    
    private var vm = SettingViewModel.shared
    
    private var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabBarViewControllers: [UIViewController] = TabBarItem.allCases
            .map { tab in
                let viewController = tab.viewController
                viewController.tabBarItem = UITabBarItem(title: tab.title, image: tab.icon, selectedImage: tab.icon)
                return viewController
            }
        
        self.viewControllers = tabBarViewControllers
        
        //bind()
    }
    
    private func bind() {
        vm.$appearance
            .sink {
                self.view.overrideUserInterfaceStyle = $0.colorScheme
            }
            .store(in: &subscriptions)
    }
}

#Preview {
    TabBarViewController()
}
