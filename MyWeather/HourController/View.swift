//
//  View.swift
//  MyWeather
//
//  Created by Ильнур Закиров on 18.06.2022.
//

import UIKit

class View: UIView {
    
    var forecast: [HourForecast]?
    
    var cityName: String?
    
    let cityNameLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: "Rubik-Medium", size: 18)
        view.text = "Казань"
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        collectionView.dataSource = self
        collectionView.delegate = self
        self.translatesAutoresizingMaskIntoConstraints = false
        
        [cityNameLabel, collectionView].forEach(self.addSubview(_:))
        
        [self.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
         
         cityNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 48),
         cityNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
         cityNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -167),
         
         collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
         collectionView.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 15),
         collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
         collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ].forEach { $0.isActive = true }
    }
}

extension View: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
