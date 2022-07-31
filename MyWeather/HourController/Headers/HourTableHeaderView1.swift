//
//  HourTableHeaderView1.swift
//  MyWeather
//
//  Created by Ильнур Закиров on 31.07.2022.
//

import UIKit

class HourTableHeaderView1: UIView {
    
    private let backgroundView: UIView =  {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "lightBlue")
        return view
    }()
    
    lazy var graphCollectionView: UICollectionView = {
        let celSize = CGSize(width: 51, height: 152)
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize = celSize
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(HourHeaderCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
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
        addSubview(backgroundView)
        backgroundView.addSubview(graphCollectionView)
        [backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
         backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
         backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
         backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
         
        graphCollectionView.topAnchor.constraint(equalTo: backgroundView.topAnchor),
        graphCollectionView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor),
        graphCollectionView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 18),
        graphCollectionView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -18),
        graphCollectionView.heightAnchor.constraint(equalToConstant: 152),
        ]
            .forEach {$0.isActive = true}
    }
}
