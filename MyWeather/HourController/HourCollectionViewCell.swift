//
//  HourCollectionViewCell.swift
//  MyWeather
//
//  Created by Ильнур Закиров on 05.05.2022.
//

import UIKit

class HourCollectionViewCell: UICollectionViewCell {
    
    var forecast: HourForecast? {
        didSet {
            tempLabel.text = "\(Int(forecast!.temp))°"
            precipitationValueLabel.text = "0"
            timeLabel.text = forecast!.dt.toTime()
        }
    }
    
    let tempLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: "Rubik-Regular", size: 14)
        return view
    }()
    
    let precipitationImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "precipitation"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let precipitationValueLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: "Rubik-Regular", size: 12)
        return view
    }()
    
    let timeLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: "Rubik-Regular", size: 14)
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
        [tempLabel, precipitationImageView, precipitationValueLabel, timeLabel].forEach(contentView.addSubview(_:))
        
        [tempLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
         tempLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 11),
         
         precipitationImageView.centerXAnchor.constraint(equalTo: tempLabel.centerXAnchor),
         precipitationImageView.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 14),
         precipitationImageView.widthAnchor.constraint(equalToConstant: 16),
         precipitationImageView.heightAnchor.constraint(equalToConstant: 16),
         
         precipitationValueLabel.centerXAnchor.constraint(equalTo: precipitationImageView.centerXAnchor),
         precipitationValueLabel.topAnchor.constraint(equalTo: precipitationImageView.bottomAnchor, constant: 4),
         
         timeLabel.centerXAnchor.constraint(equalTo: precipitationValueLabel.centerXAnchor),
         timeLabel.topAnchor.constraint(equalTo: precipitationValueLabel.bottomAnchor, constant: 8)
        ].forEach { $0.isActive = true }
    }
}
