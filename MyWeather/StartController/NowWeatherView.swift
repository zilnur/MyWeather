//
//  NowWeatherView.swift
//  MyWeather
//
//  Created by Ильнур Закиров on 02.04.2022.
//

import UIKit

class NowWeatherView: UIView {

    private let twoTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "7°/13°"
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor = .white
        return label
    }()
    
    private let oneTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "13°"
        label.font = UIFont(name: "Rubik-Medium", size: 36)
        label.textColor = .white
        return label
    }()
    
    private let precipitationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Возможен небольшой дождь"
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor = .white
        return label
    }()

}
