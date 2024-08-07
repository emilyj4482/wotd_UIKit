//
//  SceneDelegate.swift
//  wotd_UIKit
//
//  Created by EMILY on 20/07/2024.
//

import UIKit
import SwiftUI
import Combine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    @AppStorage(AppStorageKey.colorScheme) var colorSchemeValue: Int = AppStorageKey.defaultColorScheme
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .descent
        window?.rootViewController = TabBarViewController()
        window?.makeKeyAndVisible()
        
        window?.overrideUserInterfaceStyle = UIUserInterfaceStyle.init(rawValue: colorSchemeValue) ?? .unspecified
    }
}
