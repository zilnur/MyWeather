//
//  HourlyTempChangeTableViewCell.swift
//  MyWeather
//
//  Created by Ильнур Закиров on 01.05.2022.
//

import UIKit

class HourlyTempChangeTableViewCell: UITableViewCell {

    let dateLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: "Rubik-Medium", size: 18)
        return view
    }()
    
    let timeLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor(red: 0.604, green: 0.587, blue: 0.587, alpha: 1)
        view.font = UIFont(name: "Rubik-Regular", size: 14)
        return view
    }()
    
    let tempLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: "Rubik-Medium", size: 18)
        return view
    }()
    
    let descriptionLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: "Rubik-Regular", size: 14)
        return view
    }()
    
    let feelLikeLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: "Rubik-Regular", size: 14)
        return view
    }()
    
    let windLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: "Rubik-Regular", size: 14)
        view.textWithImage(imageName: "wind", text: "Ветер")
        return view
    }()
    
    let precipitationLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: "Rubik-Regular", size: 14)
        view.textWithImage(imageName: "humidity", text: "Атмомосферные осадки")
        return view
    }()
    
    let humidityLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: "Rubik-Regular", size: 14)
        view.textWithImage(imageName: "03d", text: "Облачность")
        return view
    }()
    
    let windValueLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor(red: 0.604, green: 0.587, blue: 0.587, alpha: 1)

        view.font = UIFont(name: "Rubik-Regular", size: 14)
        return view
    }()
    
    let precipitationValueLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor(red: 0.604, green: 0.587, blue: 0.587, alpha: 1)

        view.font = UIFont(name: "Rubik-Regular", size: 14)
        return view
    }()
    
    let humidityValueLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor(red: 0.604, green: 0.587, blue: 0.587, alpha: 1)

        view.font = UIFont(name: "Rubik-Regular", size: 14)
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
        contentView.backgroundColor = UIColor(named: "lightBlue")
        
        [dateLabel, timeLabel, tempLabel, descriptionLabel, feelLikeLabel, windLabel, precipitationLabel, humidityLabel, windValueLabel, precipitationValueLabel, humidityValueLabel].forEach(contentView.addSubview(_:))
        
        [dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
         dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
         
         timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
         timeLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
         
         tempLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22),
         tempLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor,constant: 10),
         
         descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 74),
         descriptionLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
         
         feelLikeLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
         feelLikeLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor,constant: 8),
         
         windLabel.leadingAnchor.constraint(equalTo: feelLikeLabel.leadingAnchor),
         windLabel.topAnchor.constraint(equalTo: feelLikeLabel.bottomAnchor, constant: 8),
         
         precipitationLabel.leadingAnchor.constraint(equalTo: windLabel.leadingAnchor),
         precipitationLabel.topAnchor.constraint(equalTo: windLabel.bottomAnchor, constant: 8),
         
         humidityLabel.leadingAnchor.constraint(equalTo: precipitationLabel.leadingAnchor),
         humidityLabel.topAnchor.constraint(equalTo: precipitationLabel.bottomAnchor, constant: 8),
         humidityLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
         
         windValueLabel.topAnchor.constraint(equalTo: feelLikeLabel.bottomAnchor, constant: 8),
         windValueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
         
         precipitationValueLabel.topAnchor.constraint(equalTo: windValueLabel.bottomAnchor, constant: 8),
         precipitationValueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
         
         humidityValueLabel.topAnchor.constraint(equalTo: precipitationValueLabel.bottomAnchor, constant: 8),
         humidityValueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ].forEach { $0.isActive = true }
    }
}
