//
//  HourForecastViewController.swift
//  MyWeather
//
//  Created by Ильнур Закиров on 02.04.2022.
//

import UIKit

class HourForecastViewController: UIViewController {
    
    let presenter: HourlyPresenterOutput
    
    private let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.register(HourlyTempChangeTableViewCell.self, forCellReuseIdentifier: "cell")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        view.separatorColor = .blue
        return view
    }()
    
    init(presenter: HourlyPresenterOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        tableView.reloadData()
        presenter.qwe()
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
        presenter.setNumberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HourlyTempChangeTableViewCell
        presenter.buildDataForTable(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = HourTableHeaderView()
        view.collectionView.dataSource = self
        view.collectionView.delegate = self
        presenter.setCityNameForHeader(label: view.cityNameLabel)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        223
    }
}

extension HourForecastViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.setNumberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HourCollectionViewCell
        presenter.buildDataForCollection(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 60, height: 112)
    }
}
