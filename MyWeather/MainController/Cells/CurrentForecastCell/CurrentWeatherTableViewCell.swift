import UIKit

class CurrentWeatherTableViewCell: UITableViewCell {
    
    let ellipseImage: UIImageView = {
        let view = UIImageView(image: UIImage(named: "Ellipse 3"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let dayNightTempLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.font = UIFont(name: "Rubik-Regular", size: 16)
        return view
    }()
    
    let currentTemp: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.font = UIFont(name: "Rubik-Medium", size: 36)
//        view.font = view.font.withSize(36)
        return view
    }()
    
    let descriptionLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.font = UIFont(name: "Rubik-Regular", size: 16)
        return view
    }()
    
    let cloudsView: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let windSpeedLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let humidityLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let dateLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .yellow
        view.font = UIFont(name: "Rubik-Regular", size: 16)
        return view
    }()
    
    let sunriseImageView: UIImageView = {
        let view = UIImageView(image: UIImage(systemName: "sunrise"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .yellow
        return view
    }()
    
    let sunriseValueLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.font = UIFont(name: "Rubik-Medium", size: 14)
        return view
    }()
    
    let sunsetImageView: UIImageView = {
        let view = UIImageView(image: UIImage(systemName: "sunset"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .yellow
        return view
    }()
    
    let sunsetValueLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.font = UIFont(name: "Rubik-Medium", size: 14)
        return view
    }()
    
    let view = CurrentDescriptionView()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.backgroundColor = UIColor(named: "blue")
        
        [ellipseImage, dayNightTempLabel,currentTemp, descriptionLabel,cloudsView, windSpeedLabel, humidityLabel, dateLabel, view, sunriseImageView, sunriseValueLabel, sunsetImageView, sunsetValueLabel].forEach(contentView.addSubview(_:))
        
        [ellipseImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 33),
         ellipseImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 17),
         ellipseImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -33),
         ellipseImage.heightAnchor.constraint(equalToConstant: 123),
         
         dayNightTempLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 33),
         dayNightTempLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
         dayNightTempLabel.heightAnchor.constraint(equalToConstant: 20),
         
         currentTemp.topAnchor.constraint(equalTo: dayNightTempLabel.bottomAnchor, constant: 5),
         currentTemp.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//         currentTemp.heightAnchor.constraint(equalToConstant: 45),
         
         descriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
         descriptionLabel.topAnchor.constraint(equalTo: currentTemp.bottomAnchor, constant: 5),
         
         view.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
         view.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 13),
         
         dateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
         dateLabel.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 15),
         dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
         
         sunriseImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
         sunriseImageView.topAnchor.constraint(equalTo: ellipseImage.bottomAnchor, constant: 5),
         sunriseImageView.widthAnchor.constraint(equalToConstant: 19),
         
         sunriseValueLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17),
         sunriseValueLabel.topAnchor.constraint(equalTo: sunriseImageView.bottomAnchor, constant: 5),
         
         sunsetImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
         sunsetImageView.topAnchor.constraint(equalTo: ellipseImage.bottomAnchor, constant: 5),
         sunsetImageView.widthAnchor.constraint(equalToConstant: 19),
         
         sunsetValueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -17),
         sunsetValueLabel.topAnchor.constraint(equalTo: sunsetImageView.bottomAnchor, constant: 5)
        ].forEach {$0.isActive = true}
        
    }
}
