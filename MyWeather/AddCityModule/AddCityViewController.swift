//
//  AddCityViewController.swift
//  MyWeather
//
//  Created by Ильнур Закиров on 18.04.2022.
//

import UIKit

class AddCityViewController: UIViewController {
    
    let coordinator: Coordinator
    
    let addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        self.title = "Добавьте город"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(addButton)
        [addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         addButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
         addButton.heightAnchor.constraint(equalToConstant: 100),
         addButton.widthAnchor.constraint(equalToConstant: 100)
        ].forEach {$0.isActive = true}
    }
    
}
