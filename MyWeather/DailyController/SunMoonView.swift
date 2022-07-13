//
//  SunMoonView.swift
//  MyWeather
//
//  Created by Ильнур Закиров on 25.06.2022.
//

import UIKit

class SunMoonView: UIView {
    
//    let backgroundView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = UIColor(patternImage: UIImage(named: "dottedLine")!)
//        return view
//    }()

    private let sunMoonLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: "Rubik-Regular", size: 18)
        view.text = "Солнце и Луна"
        return view
    }()
    
    private let moonPhaseLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: "Rubik-Regular", size: 14)
        return view
    }()
    
    lazy var sunStack = makeVerticlaStackView(sunOrMoon: "sun")
    lazy var moonStack = makeVerticlaStackView(sunOrMoon: "moon")
    
    private lazy var mainStack: UIStackView = {
        lazy var view = UIStackView(arrangedSubviews: [self.sunStack.stack, self.moonStack.stack])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
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
    
    func setupViews() {
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        [sunMoonLabel, moonPhaseLabel, mainStack].forEach(self.addSubview(_:))
        [
            sunMoonLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            sunMoonLabel.topAnchor.constraint(equalTo: self.topAnchor),
            
            moonPhaseLabel.topAnchor.constraint(equalTo: self.topAnchor),
            moonPhaseLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            mainStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainStack.topAnchor.constraint(equalTo: sunMoonLabel.bottomAnchor, constant: 15),
            mainStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainStack.heightAnchor.constraint(equalToConstant: 100),
            mainStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            sunStack.stack.widthAnchor.constraint(equalTo: mainStack.widthAnchor, multiplier: 0.5)
        ].forEach({$0.isActive = true})
    }
}

extension SunMoonView {
    
    func makeVerticlaStackView(sunOrMoon: String) -> (timeLabel: UILabel, riseLabel: UILabel, setLabel: UILabel, stack: UIStackView) {
        let stack1 = makeHorizontalStackWithImage(imageName: sunOrMoon)
        let stack2 = makeHorizontalStackWithLabel(labelText: "Восход")
        let stack3 = makeHorizontalStackWithLabel(labelText: "Заход")
        
        let stackView: UIStackView = {
            let view = UIStackView(arrangedSubviews: [stack1.stack, stack2.stack, stack3.stack])
            view.axis = .vertical
            view.spacing = 0.2
            view.backgroundColor = .blue
            return view
        }()
        
        return (stack1.label, stack2.label, stack3.label, stackView)
    }
    
    func makeHorizontalStackWithImage(imageName: String) -> (stack: UIStackView, label: UILabel) {
        
        let imageView: UIImageView = {
            let view = UIImageView(image: UIImage(named: imageName))
            view.translatesAutoresizingMaskIntoConstraints = false
            view.contentMode = .scaleAspectFit
            return view
        }()
        
        let label: UILabel = {
            let view = UILabel()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.font = UIFont(name: "Rubik-Regular", size: 16)
            view.textAlignment = .right
            view.text = "33"
            return view
        }()
        
        lazy var stackView: UIStackView = {
            let view = UIStackView(arrangedSubviews: [imageView, label])
            view.translatesAutoresizingMaskIntoConstraints = false
            view.isLayoutMarginsRelativeArrangement = true
            view.directionalLayoutMargins = .init(top: 0, leading: 16, bottom: 0, trailing: 10)
            view.backgroundColor = .white
            return view
        }()
        
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalToConstant: 36),
            imageView.heightAnchor.constraint(equalToConstant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 20)
        ])
        
        return (stackView, label)
    }
    
    func makeHorizontalStackWithLabel(labelText: String) -> (stack: UIStackView, label: UILabel) {
        
        let sunriseSunsetLabel: UILabel = {
            let view = UILabel()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.font = UIFont(name: "Rubik-Regular", size: 14)
            view.textColor = .lightGray
            view.text = labelText
            return view
        }()
        
        let label: UILabel = {
            let view = UILabel()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.font = UIFont(name: "Rubik-Regular", size: 16)
            view.textAlignment = .right
            view.text = "33"
            return view
        }()
        
        lazy var stackView: UIStackView = {
            let view = UIStackView(arrangedSubviews: [sunriseSunsetLabel, label])
            view.axis = .horizontal
            view.backgroundColor = .white
            view.isLayoutMarginsRelativeArrangement = true
            view.directionalLayoutMargins = .init(top: 0, leading: 16, bottom: 0, trailing: 10)
            return view
        }()
        
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        return (stackView, label)
    }
    
}
