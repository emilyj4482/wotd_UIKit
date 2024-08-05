//
//  WebViewController.swift
//  wotd_UIKit
//
//  Created by EMILY on 06/08/2024.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    private lazy var webView = WKWebView()
    
    private lazy var closeButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        
        button.title = "Close"
        button.tintColor = .accent
        button.target = self
        button.action = #selector(closeButtonTapped(_:))
        
        return button
    }()
    
    override func loadView() {
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebView()
        setup()
    }
    
    private func loadWebView() {
        guard let url = URL(string: "https://openweathermap.org") else { return }
        webView.load(URLRequest(url: url))
    }
    
    private func setup() {
        view.backgroundColor = .descent
        navigationController?.navigationBar.backgroundColor = .moreAccent
        navigationItem.rightBarButtonItem = closeButton
    }
    
    @objc private func closeButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}

#Preview {
    WebViewController()
}
