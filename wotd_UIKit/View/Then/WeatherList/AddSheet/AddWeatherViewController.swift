//
//  AddWeatherViewController.swift
//  wotd_UIKit
//
//  Created by EMILY on 01/08/2024.
//

import UIKit
import SnapKit
import Combine

final class AddWeatherViewController: UIViewController {
    
    private let vm = AddViewModel.shared
    
    private var subscriptions = Set<AnyCancellable>()
    
    private var selectedCity: City?
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date"
        return label
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.text = "City"
        return label
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.tintColor = .accent
        
        return datePicker
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "Enter a city name."
        textField.borderStyle = .none
        textField.textColor = .accent
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        
        let action = UIAction { [weak self] _ in
            self?.textField.text = ""
            self?.resetFormat()
        }
        
        button.addAction(action, for: .touchUpInside)
        button.setImage(UIImage(systemName: "x.circle.fill"), for: .normal)
        button.tintColor = .gray
        button.contentMode = .scaleAspectFit
        button.isHidden = true
        
        return button
    }()
    
    private lazy var searchResultTable: UITableView = {
        let tableView = UITableView()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchResultCell.self, forCellReuseIdentifier: SearchResultCell.identifier)
        tableView.backgroundColor = .addSheet
        
        return tableView
    }()
    
    private lazy var selectImage: UIImageView = {
        let imageView = UIImageView()
            
        imageView.image = UIImage(systemName: "checkmark.circle.fill")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        
        let action = UIAction { [weak self] _ in
            guard let date = self?.datePicker.date,
                  let city = self?.selectedCity
            else { return }
            
            self?.vm.getWeather(date: date, city: city)
            self?.dismiss(animated: true)
        }

        button.configuration = .filled()
        button.configuration?.title = "Add"
        button.configuration?.cornerStyle = .capsule
        button.configuration?.baseForegroundColor = .descent
        button.configuration?.baseBackgroundColor = .accent
        
        button.addAction(action, for: .touchUpInside)
        
        return button
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        layout()
        bind()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        resetFormat()
    }
    
    private func addSubviews() {
        [dateLabel, cityLabel, datePicker, textField, deleteButton, searchResultTable, selectImage, addButton].forEach { view.addSubview($0) }
        // navigationBar 영역이 date picker를 가려 touch가 안되는 문제 처리
        navigationController?.navigationBar.isHidden = true
    }
    
    private func layout() {
        sheetPresentationController?.detents = [.custom(resolver: { _ in return 300 })]
        view.backgroundColor = .addSheet
        
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().offset(20)
        }
        
        cityLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(30)
            $0.leading.equalTo(dateLabel.snp.leading)
        }
        
        datePicker.snp.makeConstraints {
            $0.centerY.equalTo(dateLabel.snp.centerY)
            $0.leading.equalTo(dateLabel.snp.trailing).offset(20)
        }
        
        textField.snp.makeConstraints {
            $0.centerY.equalTo(cityLabel.snp.centerY)
            $0.leading.equalTo(datePicker.snp.leading)
            $0.width.equalTo(260)
        }
        
        deleteButton.snp.makeConstraints {
            $0.centerY.equalTo(textField.snp.centerY)
            $0.leading.equalTo(textField.snp.trailing).offset(10)
        }
        
        addButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(textField.snp.bottom).offset(150)
            $0.width.equalTo(100)
            $0.height.equalTo(50)
        }
        
        searchResultTable.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(10)
            $0.bottom.equalTo(addButton.snp.top).offset(-5)
            $0.leading.equalTo(textField.snp.leading)
            $0.trailing.equalTo(textField.snp.trailing)
        }
        
        selectImage.snp.makeConstraints {
            $0.top.equalTo(searchResultTable.snp.top).offset(25)
            $0.leading.equalTo(deleteButton.snp.leading)
            $0.trailing.equalTo(deleteButton.snp.trailing)
        }
    }
    
    private func bind() {
        vm.$isCitySelected
            .sink { [self] in
                if $0 == true {
                    selectImage.isHidden = false
                    addButton.isEnabled = true
                } else {
                    selectImage.isHidden = true
                    addButton.isEnabled = false
                }
            }
            .store(in: &subscriptions)
    }
    
    private func resetFormat() {
        vm.cities = []
        searchResultTable.reloadData()
        vm.isCitySelected = false
    }
}

extension AddWeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // keyboard return tap 시 keyboard dismiss
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        // textfield 입력값으로 행정구역명 search
        vm.searchCities(searchText: textField.text ?? "")
        searchResultTable.reloadData()
        if textField.text?.count == 0 {
            deleteButton.isHidden = true
            resetFormat()
        } else {
            deleteButton.isHidden = false
        }
    }
}

extension AddWeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.identifier, for: indexPath) as? SearchResultCell else { return UITableViewCell() }
        
        let city = vm.cities[indexPath.row]
        cell.setCityName(city: city)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        vm.isCitySelected.toggle()
        
        if vm.isCitySelected == true {
            let city = vm.cities[indexPath.row]
            selectedCity = city
            vm.setParams(date: datePicker.date, city: city)
        } else {
            selectedCity = nil
        }
    }
}

#Preview {
    AddWeatherViewController()
}
