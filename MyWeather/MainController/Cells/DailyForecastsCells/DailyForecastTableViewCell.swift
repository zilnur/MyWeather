//
//  DailyForecastTableViewCell.swift
//  MyWeather
//
//  Created by Ильнур Закиров on 30.04.2022.
//

import UIKit

class DailyForecastTableViewCell: UITableViewCell {
    
    var dailies: [DailyForecastData]?

    let dailyLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Ежедневный прогноз"
        view.font = UIFont(name: "Rubik-Medium", size: 18)
        return view
    }()
    
    let daisLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.attributedText = NSMutableAttributedString(string: "7 дней", attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.kern: 0.16])
        view.font = UIFont(name: "Rubik-Regular", size: 16)
        return view
    }()
    
    let dailyForecastCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(DailyCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        return view
    }()
    
    var onVC: (Int) -> () = {_ in }
    
    override var isSelected: Bool {
        didSet {
            self.contentView.backgroundColor = .white
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        dailyForecastCollectionView.dataSource = self
        dailyForecastCollectionView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        [dailyLabel, daisLabel, dailyForecastCollectionView].forEach(contentView.addSubview(_:))
        
        [dailyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
         dailyLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
         
         daisLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
         daisLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
         daisLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -472),
         
         dailyForecastCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
         dailyForecastCollectionView.topAnchor.constraint(equalTo: daisLabel.bottomAnchor),
         dailyForecastCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
         dailyForecastCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ].forEach {$0.isActive = true}
    }
}

extension DailyForecastTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dailies!.count - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dailyForecastCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? DailyCollectionViewCell
        cell?.setViewsValues(data: dailies![indexPath.item])
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: contentView.frame.width, height: 56)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = indexPath.item
        onVC(item)
    }
}
