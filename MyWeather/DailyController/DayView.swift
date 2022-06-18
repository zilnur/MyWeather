//
//  DayView.swift
//  MyWeather
//
//  Created by Ильнур Закиров on 21.05.2022.
//

import UIKit

class DayView: UIView {

    let timeOfDayLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: "Rubik-Regular", size: 18)
        view.text = "День"
        return view
    }()
    
    let humidityImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "precipitation"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tempLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: "Rubik-Regular", size: 30)
        view.text = "23"
        return view
    }()
    
    let descriptionLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: "Rubik-Medium", size: 18)
        view.text = "Тест"
        return view
    }()
    
    lazy var feelLikeStack = makeStackView()
    lazy var windStack = makeStackView()
    lazy var uviStack = makeStackView()
    lazy var rainStack = makeStackView()
    lazy var cloudsStack = makeStackView()
    
    private lazy var mainStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            self.feelLikeStack.stack,
            self.windStack.stack,
            self.uviStack.stack,
            self.rainStack.stack,
            self.cloudsStack.stack
        ])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 0.5
        view.backgroundColor = .blue
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeStackView() -> (image: UIImageView, desLabel: UILabel, valueLabel: UILabel, stack: UIStackView) {
        let image: UIImageView = {
            let view = UIImageView(image: UIImage(named: "cloud"))
            view.translatesAutoresizingMaskIntoConstraints = false
            view.contentMode = .scaleAspectFit
            return view
        }()
        let descriptionLabel: UILabel = {
            let view = UILabel()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.font = UIFont(name: "Rubik-Regular", size: 14)
            view.text = "Тест"
            return view
        }()
        let valueLabel: UILabel = {
            let view = UILabel()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.font = UIFont(name: "Rubik-Regular", size: 18)
            view.textAlignment = .right
            return view
        }()
        let stackView: UIStackView = {
            let view = UIStackView(arrangedSubviews: [image, descriptionLabel, valueLabel])
            view.axis = .horizontal
            view.spacing = 16
            view.backgroundColor = UIColor(named: "lightBlue")
            view.isLayoutMarginsRelativeArrangement = true
            view.directionalLayoutMargins = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
            return view
        }()
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: 20),
            stackView.heightAnchor.constraint(equalToConstant: 46),
        ])
        return (image, descriptionLabel, valueLabel, stackView)
    }
    
    func setupViews() {
        [timeOfDayLabel, humidityImageView, tempLabel, descriptionLabel, mainStack].forEach(self.addSubview(_:))
        
        self.backgroundColor = UIColor(named: "lightBlue")
        self.translatesAutoresizingMaskIntoConstraints = false
        
        [timeOfDayLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
         timeOfDayLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 21),
         
         humidityImageView.leadingAnchor.constraint(equalTo: timeOfDayLabel.trailingAnchor, constant: 76),
         humidityImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 21),
         humidityImageView.heightAnchor.constraint(equalToConstant: 29),
         humidityImageView.widthAnchor.constraint(equalToConstant: 26),
         
         tempLabel.leadingAnchor.constraint(equalTo: humidityImageView.trailingAnchor, constant: 10),
         tempLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
         
         descriptionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
         descriptionLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 11),
         
         mainStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
         mainStack.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
         mainStack.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ].forEach {$0.isActive = true}
    }
}
