import UIKit

class CurrentDescriptionView: UIView {
    
    let cloudsImageView: UIImageView = {
        let view =  UIImageView(image: UIImage(named: "02d"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let cloudsValueLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: "Rubik-Regular", size: 16)
        view.textColor = .white
        return view
    }()
    
    let windImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "wind"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let windValueLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.font = UIFont(name: "Rubik-Regular", size: 16)
        return view
    }()
    
    let humidityImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "humidity"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let humidityValueLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.font = UIFont(name: "Rubik-Regular", size: 16)
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
        [cloudsImageView, cloudsValueLabel, windImageView, windValueLabel, humidityImageView, humidityValueLabel].forEach(self.addSubview(_:))
        
        [cloudsImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
         cloudsImageView.topAnchor.constraint(equalTo: self.topAnchor),
         cloudsImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
         
         cloudsValueLabel.leadingAnchor.constraint(equalTo: cloudsImageView.trailingAnchor, constant: 5),
         cloudsValueLabel.topAnchor.constraint(equalTo: self.topAnchor),
         cloudsValueLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
         
         windImageView.leadingAnchor.constraint(equalTo: cloudsValueLabel.trailingAnchor, constant:  20),
         windImageView.topAnchor.constraint(equalTo: self.topAnchor),
         windImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
         
         windValueLabel.leadingAnchor.constraint(equalTo: windImageView.trailingAnchor, constant:  7),
         windValueLabel.topAnchor.constraint(equalTo: self.topAnchor),
         windValueLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
         
         humidityImageView.leadingAnchor.constraint(equalTo: windValueLabel.trailingAnchor, constant: 20),
         humidityImageView.topAnchor.constraint(equalTo: self.topAnchor),
         humidityImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
         
         humidityValueLabel.leadingAnchor.constraint(equalTo: humidityImageView.trailingAnchor, constant:  5),
         humidityValueLabel.topAnchor.constraint(equalTo: self.topAnchor),
         humidityValueLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
         humidityValueLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ].forEach {$0.isActive = true}
    }
}

