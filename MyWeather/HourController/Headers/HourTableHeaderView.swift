//
//  View.swift
//  MyWeather
//
//  Created by Ильнур Закиров on 18.06.2022.
//

import UIKit

class HourTableHeaderView: UIView {
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
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
