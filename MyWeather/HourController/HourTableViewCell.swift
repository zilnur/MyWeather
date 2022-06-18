//
//  HourTableViewCell.swift
//  MyWeather
//
//  Created by Ильнур Закиров on 05.05.2022.
//

import UIKit

class HourTableViewCell: UITableViewCell {
    
    var forecast: [HourForecast]?
    
    var cityName: String?
    
    let cityNameLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: "Rubik-Medium", size: 18)
        return view
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(HourCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        view.backgroundColor = UIColor(named: "lightBlue")
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        [cityNameLabel, collectionView].forEach(contentView.addSubview(_:))
        
        [cityNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 48),
         cityNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
         cityNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -167),
         
         collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
         collectionView.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 15),
         collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
         collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ].forEach { $0.isActive = true }
    }
}

extension HourTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        forecast!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HourCollectionViewCell
        cell?.forecast = self.forecast![indexPath.item]
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 60, height: 112)
    }
}
