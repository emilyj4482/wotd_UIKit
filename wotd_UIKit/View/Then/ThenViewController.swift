//
//  ThenViewController.swift
//  wotd_UIKit
//
//  Created by EMILY on 20/07/2024.
//

import UIKit
import SnapKit
import Combine

class ThenViewController: UIViewController {
    
    private var vm = ThenViewModel.shared
    
    private var subscriptions = Set<AnyCancellable>()
    
    private lazy var emptyView = EmptyView()
    
    private lazy var weatherListView = WeatherListView()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        
        let action = UIAction { [weak self] _ in
            self?.presentAddWeatherViewController()
        }
        
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.tintColor = .accent
        button.imageView?.contentMode = .scaleAspectFit
        button.addAction(action, for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherListView.delegate = self
        bind()
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
    
    private func bind() {
        vm.$weathers
            .sink { [self] weathers in
                if weathers.isEmpty {
                    addSubviews(emptyView)
                    layout(emptyView)
                } else {
                    addSubviews(weatherListView)
                    layout(weatherListView)
                }
            }
            .store(in: &subscriptions)
    }
    
    func presentAddWeatherViewController() {
        let vc = UINavigationController(rootViewController: AddWeatherViewController())
        present(vc, animated: true)
    }
}

extension ThenViewController: ThenViewDelegate {
    func pushComparisionViewController(with weather: ThenWeather) {
        navigationController?.pushViewController(ComparisionViewController(weather: weather), animated: true)
    }
    
    func showActionSheet(_ weather: ThenWeather, index: Int) {
        let alert = UIAlertController(title: "", message: "Delete this weather?", preferredStyle: .actionSheet)
        let deleteButton = UIAlertAction(title: "Delete", style: .default) { [unowned self] _ in
            vm.deleteWeather(index)
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(deleteButton)
        alert.addAction(cancelButton)
        self.present(alert, animated: true)
    }
}

#Preview {
    ThenViewController()
}
