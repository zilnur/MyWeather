//
//  HourForecastViewController.swift
//  MyWeather
//
//  Created by Ильнур Закиров on 02.04.2022.
//

import UIKit

class HourForecastViewController: UIViewController {
    
    let hourlyForecast: [HourForecast]
    
//    let city: String
    
    private let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.register(HourlyTempChangeTableViewCell.self, forCellReuseIdentifier: "cell")
        view.register(HourTableViewCell.self, forCellReuseIdentifier: "cell1")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        view.separatorColor = .blue
        return view
    }()
    
    init(hourlyForecast: [HourForecast]) {
        self.hourlyForecast = hourlyForecast
//        self.city = city
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        tableView.reloadData()
    }
}

extension HourForecastViewController {
    func setupViews() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        [tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
         tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
         tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
         tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ].forEach {$0.isActive = true}
    }
}

extension HourForecastViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch section {
//        case 0:
//            return 1
//        case 1:
//            return 24
//        default:
//            return 0
//        }
        24
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HourlyTempChangeTableViewCell
        cell?.forecast = hourlyForecast[indexPath.item]
//        let cell1 = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as? HourTableViewCell
//        cell1?.forecast = self.hourlyForecast
//        cell1?.cityNameLabel.text = self.city
//        switch indexPath.section {
//        case 0:
//            return cell1 ?? UITableViewCell()
//        default:
//            return cell ?? UITableViewCell()
//        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = View()
        view.forecast = self.hourlyForecast
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        223
    }
    
}

