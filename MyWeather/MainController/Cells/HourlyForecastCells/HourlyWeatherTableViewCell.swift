//
//  HourlyWeatherTableViewCell.swift
//  MyWeather
//
//  Created by Ильнур Закиров on 29.04.2022.
//

import UIKit

class HourlyWeatherTableViewCell: UITableViewCell {
    
    var hourlyForecasts: [HourlyForecastData]?
    let date: Int32 = {
        let date = Date()
        let interval = date.timeIntervalSince1970
        let myInt = Int32(interval)
        return myInt
    }()
    
    let moreDetailetLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.font = UIFont(name: "Rubik-Regular", size: 16)
        view.attributedText = NSMutableAttributedString(string: "Подробнее на 24 часа", attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.kern: 0.16])
        return view
    }()
    
    let hourlyColletctionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(HourlyCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        hourlyColletctionView.dataSource = self
        hourlyColletctionView.delegate = self
        setupViews()
        hourlyColletctionView.reloadData()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupViews() {
        selectionStyle = .none
        [moreDetailetLabel, hourlyColletctionView].forEach(contentView.addSubview(_:))
        
        [moreDetailetLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
         moreDetailetLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
         moreDetailetLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -103),
         
         hourlyColletctionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
         hourlyColletctionView.topAnchor.constraint(equalTo: moreDetailetLabel.bottomAnchor, constant: 10),
         hourlyColletctionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
         hourlyColletctionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ].forEach {$0.isActive = true}
    }
}

extension HourlyWeatherTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = hourlyColletctionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HourlyCollectionViewCell
        cell.setViewsValues(data: hourlyForecasts![indexPath.item])
//        if cell.hourForecast!.dt < date {
//            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
//        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 44, height: 83)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
