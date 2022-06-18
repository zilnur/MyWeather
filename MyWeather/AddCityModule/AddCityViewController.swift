//
//  AddCityViewController.swift
//  MyWeather
//
//  Created by Ильнур Закиров on 18.04.2022.
//

import UIKit

class AddCityViewController: UIViewController {
    
    let addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .black
        button.addTarget(nil, action: #selector(addCity), for: .touchUpInside)
        return button
    }()
    
    var onAdd = {}

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(addButton)
        [addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         addButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
         addButton.heightAnchor.constraint(equalToConstant: 100),
         addButton.widthAnchor.constraint(equalToConstant: 100)
        ].forEach {$0.isActive = true}
    }
    
    @objc func addCity() {
        let alert = UIAlertController(title: "Добавть город", message: "Введите название города", preferredStyle: .alert)
        alert.addTextField()
        let alertOk = UIAlertAction(title: "OK", style: .default) {_ in
            guard let text = alert.textFields?[0].text else { return }
            DatabaseService.shared.addCity(cityName: text.convert())
            self.onAdd()
        }
        let alertCancel = UIAlertAction(title: "Cancel", style: .cancel)
        [alertOk, alertCancel].forEach {alert.addAction($0)}
        self.present(alert, animated: true)
    }
    
}
